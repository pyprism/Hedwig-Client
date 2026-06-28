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
}
