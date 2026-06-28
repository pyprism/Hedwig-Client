import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/sync/sync_engine.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'compose_controller.g.dart';

const _undoSendWindow = Duration(seconds: 8);

class ComposeAttachmentRequest {
  const ComposeAttachmentRequest({
    required this.filename,
    required this.contentType,
    required this.content,
    required this.sizeBytes,
    this.contentId,
  });

  final String filename;
  final String contentType;
  final String content;
  final int sizeBytes;
  final String? contentId;

  Map<String, dynamic> toPayload() => {
    'filename': filename,
    'content_type': contentType,
    'content': content,
    if (contentId != null && contentId!.isNotEmpty) 'content_id': contentId,
  };

  Map<String, dynamic> toDraftJson() => {
    ...toPayload(),
    'size_bytes': sizeBytes,
  };

  factory ComposeAttachmentRequest.fromDraftJson(Map<String, dynamic> json) {
    return ComposeAttachmentRequest(
      filename: json['filename'] as String? ?? 'attachment',
      contentType:
          json['content_type'] as String? ?? 'application/octet-stream',
      content: json['content'] as String? ?? '',
      sizeBytes: json['size_bytes'] as int? ?? 0,
      contentId: json['content_id'] as String?,
    );
  }
}

class SavedDraft {
  const SavedDraft({required this.id});

  final String id;
}

@riverpod
class ComposeController extends _$ComposeController {
  int? lastQueuedOutboxId;
  String? lastLocalMessageId;

  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> send(
    SendMessageRequest req, {
    List<ComposeAttachmentRequest> attachments = const [],
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(appDatabaseProvider);
      final localId = 'local-${DateTime.now().microsecondsSinceEpoch}';
      final notBefore = DateTime.now().toUtc().add(_undoSendWindow);

      final body = {
        'mailbox': req.mailboxId,
        if (req.senderIdentityId != null)
          'sender_identity': req.senderIdentityId,
        'to': req.to.map((e) => {'email': e.email, 'name': e.name}).toList(),
        if (req.cc.isNotEmpty) 'cc': req.cc.map((e) => e.toJson()).toList(),
        if (req.bcc.isNotEmpty) 'bcc': req.bcc.map((e) => e.toJson()).toList(),
        'subject': req.subject,
        if (req.bodyText != null) 'body_text': req.bodyText,
        if (req.bodyHtml != null) 'body_html': req.bodyHtml,
        if (req.replyToMessageId != null)
          'reply_to_message': req.replyToMessageId,
        if (req.scheduledAt != null)
          'scheduled_at': req.scheduledAt!.toIso8601String(),
        if (attachments.isNotEmpty)
          'attachments': attachments.map((a) => a.toPayload()).toList(),
      };

      await _insertOptimisticMessage(db, localId, req, attachments);

      // Enqueue in outbox — sync engine flushes when online.
      final outboxId = await db.outboxDao.enqueue(
        operation: 'send_message',
        payloadJson: jsonEncode({
          'localId': localId,
          'notBefore': notBefore.toIso8601String(),
          'body': body,
        }),
      );
      lastQueuedOutboxId = outboxId;
      lastLocalMessageId = localId;

      // Try immediate flush.
      unawaited(ref.read(syncEngineProvider).flushOutbox());
      unawaited(
        Future<void>.delayed(_undoSendWindow, () {
          ref.read(syncEngineProvider).flushOutbox();
        }),
      );
    });
  }

  Future<SavedDraft> saveDraft(
    SendMessageRequest req, {
    String? draftId,
    List<ComposeAttachmentRequest> attachments = const [],
    List<dynamic>? bodyDelta,
    bool htmlSourceMode = false,
  }) async {
    state = const AsyncLoading();
    late final SavedDraft savedDraft;
    state = await AsyncValue.guard(() async {
      final db = ref.read(appDatabaseProvider);
      final localId =
          draftId ?? 'draft-${DateTime.now().microsecondsSinceEpoch}';
      await _upsertDraftMessage(
        db,
        localId,
        req,
        attachments,
        bodyDelta: bodyDelta,
        htmlSourceMode: htmlSourceMode,
      );
      savedDraft = SavedDraft(id: localId);
    });
    if (state.hasError) {
      Error.throwWithStackTrace(
        state.error!,
        state.stackTrace ?? StackTrace.current,
      );
    }
    return savedDraft;
  }

  Future<void> undoLastSend() async {
    final outboxId = lastQueuedOutboxId;
    final localId = lastLocalMessageId;
    if (outboxId == null || localId == null) return;
    final db = ref.read(appDatabaseProvider);
    await db.outboxDao.discard(outboxId);
    await db.messageDao.deleteById(localId);
    lastQueuedOutboxId = null;
    lastLocalMessageId = null;
  }

  Future<void> deleteDraft(String draftId) async {
    final db = ref.read(appDatabaseProvider);
    await db.transaction(() async {
      await db.messageDao.deleteById(draftId);
      await db.threadDao.deleteByIdFolder(draftId, 'drafts');
    });
  }

  /// Inserts a local `queued` row immediately so the message shows up in
  /// the thread/sent folder before the sync engine has reached the server.
  /// Replaced with the real server message once the outbox entry is sent.
  Future<void> _insertOptimisticMessage(
    AppDatabase db,
    String localId,
    SendMessageRequest req,
    List<ComposeAttachmentRequest> attachments,
  ) async {
    final mailbox = await db.mailboxDao.getById(req.mailboxId);
    String? threadId;
    if (req.replyToMessageId != null) {
      final original = await db.messageDao.getById(req.replyToMessageId!);
      threadId = original?.threadId;
    }

    await db.messageDao.upsertAll([
      MessagesCompanion.insert(
        id: localId,
        mailboxId: req.mailboxId,
        threadId: Value(threadId),
        direction: 'outbound',
        status: 'queued',
        folder: const Value('sent'),
        fromAddress: mailbox?.emailAddress ?? '',
        toAddressesJson: Value(
          jsonEncode(req.to.map((e) => e.toJson()).toList()),
        ),
        ccAddressesJson: Value(
          jsonEncode(req.cc.map((e) => e.toJson()).toList()),
        ),
        bccAddressesJson: Value(
          jsonEncode(req.bcc.map((e) => e.toJson()).toList()),
        ),
        subject: req.subject,
        bodyText: Value(req.bodyText),
        bodyHtml: Value(req.bodyHtml),
        hasAttachments: Value(attachments.isNotEmpty),
        attachmentsJson: Value(
          jsonEncode(
            attachments
                .asMap()
                .entries
                .map(
                  (entry) => {
                    'id': '$localId-attachment-${entry.key}',
                    'filename': entry.value.filename,
                    'content_type': entry.value.contentType,
                    'size_bytes': entry.value.sizeBytes,
                    'is_inline': entry.value.contentId?.isNotEmpty == true,
                    if (entry.value.contentId?.isNotEmpty == true)
                      'content_id': entry.value.contentId,
                  },
                )
                .toList(),
          ),
        ),
        scheduledAt: Value(req.scheduledAt),
        createdAt: DateTime.now().toUtc(),
      ),
    ]);
  }

  Future<void> _upsertDraftMessage(
    AppDatabase db,
    String localId,
    SendMessageRequest req,
    List<ComposeAttachmentRequest> attachments, {
    List<dynamic>? bodyDelta,
    bool htmlSourceMode = false,
  }) async {
    final mailbox = await db.mailboxDao.getById(req.mailboxId);
    final now = DateTime.now().toUtc();
    final subject = req.subject.trim();
    final metadata = {
      if (req.senderIdentityId != null)
        'sender_identity_id': req.senderIdentityId,
      if (req.replyToMessageId != null)
        'reply_to_message_id': req.replyToMessageId,
      'compose_html': true,
      'html_source_mode': htmlSourceMode,
      'body_delta': ?bodyDelta,
      'compose_attachments': attachments.map((a) => a.toDraftJson()).toList(),
    };
    final attachmentRows = attachments
        .asMap()
        .entries
        .map(
          (entry) => {
            'id': '$localId-attachment-${entry.key}',
            'filename': entry.value.filename,
            'content_type': entry.value.contentType,
            'size_bytes': entry.value.sizeBytes,
            'is_inline': entry.value.contentId?.isNotEmpty == true,
            if (entry.value.contentId?.isNotEmpty == true)
              'content_id': entry.value.contentId,
          },
        )
        .toList();
    final participants = [
      if (req.to.isNotEmpty) ...req.to.map((e) => e.email) else 'Draft',
    ];
    final snippet = (req.bodyText ?? '').trim();

    await db.transaction(() async {
      await db.messageDao.upsertAll([
        MessagesCompanion.insert(
          id: localId,
          mailboxId: req.mailboxId,
          threadId: Value(localId),
          direction: 'outbound',
          status: 'draft',
          folder: const Value('drafts'),
          fromAddress: mailbox?.emailAddress ?? '',
          toAddressesJson: Value(
            jsonEncode(req.to.map((e) => e.toJson()).toList()),
          ),
          ccAddressesJson: Value(
            jsonEncode(req.cc.map((e) => e.toJson()).toList()),
          ),
          bccAddressesJson: Value(
            jsonEncode(req.bcc.map((e) => e.toJson()).toList()),
          ),
          subject: subject,
          snippet: Value(snippet.isEmpty ? null : snippet),
          bodyText: Value(req.bodyText),
          bodyHtml: Value(req.bodyHtml),
          hasAttachments: Value(attachments.isNotEmpty),
          attachmentsJson: Value(jsonEncode(attachmentRows)),
          metadataJson: Value(jsonEncode(metadata)),
          scheduledAt: Value(req.scheduledAt),
          createdAt: now,
        ),
      ]);
      await db.threadDao.upsertAll([
        ThreadsCompanion.insert(
          id: localId,
          mailboxId: req.mailboxId,
          subject: subject.isEmpty ? '(no subject)' : subject,
          messageCount: const Value(1),
          hasUnread: const Value(false),
          unreadCount: const Value(0),
          snippet: Value(snippet.isEmpty ? null : snippet),
          latestDirection: const Value('outbound'),
          hasAttachments: Value(attachments.isNotEmpty),
          attachmentFilenamesJson: Value(
            jsonEncode(attachments.map((a) => a.filename).toList()),
          ),
          participantsJson: Value(jsonEncode(participants)),
          folder: const Value('drafts'),
          updatedAt: now,
          lastMessageAt: now,
        ),
      ]);
    });
  }
}
