import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/core/sync/sync_engine.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
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
    this.serverId,
  });

  final String filename;
  final String contentType;
  final String content;
  final int sizeBytes;
  final String? contentId;

  /// Server-side `EmailAttachment` id, set when this attachment was loaded from
  /// a draft fetched from the backend. Such an attachment has no local [content]
  /// (the staged bytes aren't downloadable), so it is referenced by id when
  /// re-saving the draft and the draft must be sent via the send-draft endpoint.
  final String? serverId;

  bool get isReference => serverId != null && content.isEmpty;

  Map<String, dynamic> toPayload() => {
    'filename': filename,
    'content_type': contentType,
    'content': content,
    if (contentId != null && contentId!.isNotEmpty) 'content_id': contentId,
  };

  /// Attachment payload for the draft endpoints: a reference (`{id}`) to keep an
  /// already-staged attachment, or the full base64 content for a new one.
  Map<String, dynamic> toDraftPayload() =>
      isReference ? {'id': serverId} : toPayload();

  Map<String, dynamic> toDraftJson() => {
    ...toPayload(),
    'size_bytes': sizeBytes,
    if (serverId != null) 'id': serverId,
  };

  factory ComposeAttachmentRequest.fromDraftJson(Map<String, dynamic> json) {
    return ComposeAttachmentRequest(
      filename: json['filename'] as String? ?? 'attachment',
      contentType:
          json['content_type'] as String? ?? 'application/octet-stream',
      content: json['content'] as String? ?? '',
      sizeBytes: json['size_bytes'] as int? ?? 0,
      contentId: json['content_id'] as String?,
      serverId: json['id'] as String?,
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

      // Resolve the sender identity up front. Queuing with a blank From when
      // the mailbox isn't cached would surface an empty sender, so block send.
      final mailbox = await db.mailboxDao.getById(req.mailboxId);
      if (mailbox == null || mailbox.emailAddress.isEmpty) {
        throw const ApiException(
          UnknownFailure(
            message: 'Sender mailbox unavailable. Reopen and try again.',
          ),
        );
      }

      final localId = 'local-${DateTime.now().microsecondsSinceEpoch}';
      // A message scheduled for the future is held in the outbox until its
      // send time; otherwise it flushes after the undo window.
      final scheduledAt = req.scheduledAt?.toUtc();
      final isScheduled =
          scheduledAt != null && scheduledAt.isAfter(DateTime.now().toUtc());
      final notBefore = isScheduled
          ? scheduledAt
          : DateTime.now().toUtc().add(_undoSendWindow);

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

      await _insertOptimisticMessage(
        db,
        localId,
        req,
        attachments,
        mailbox: mailbox,
        isScheduled: isScheduled,
      );

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
      // Carry forward the server-assigned ids so re-saves PATCH the same remote
      // draft (instead of creating a new one) and keep the dedup key intact.
      final existingRow = await db.messageDao.getById(localId);
      final serverDraftId = _serverDraftId(existingRow);
      final serverDraftThreadId = _serverDraftThreadId(existingRow);
      await _upsertDraftMessage(
        db,
        localId,
        req,
        attachments,
        bodyDelta: bodyDelta,
        htmlSourceMode: htmlSourceMode,
        serverDraftId: serverDraftId,
        serverDraftThreadId: serverDraftThreadId,
      );
      await _enqueueDraftSync(db, localId, serverDraftId, req, attachments);
      // Best-effort immediate flush; offline saves stay queued in the outbox
      // and flush on reconnect, so a flush failure must not fail the save.
      _tryFlushOutbox();
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

  /// Sends a draft that was loaded from the server (and so has reference-only
  /// attachments) by promoting it server-side via the send-draft endpoint.
  /// Persists final edits as a PATCH first, then queues the promote; the local
  /// draft is removed optimistically and the promoted message reconciles into
  /// Sent on the next refresh.
  Future<void> sendDraft({
    required String localDraftId,
    required SendMessageRequest req,
    required List<ComposeAttachmentRequest> attachments,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(appDatabaseProvider);
      final existingRow = await db.messageDao.getById(localDraftId);
      final serverDraftId = _serverDraftId(existingRow);
      if (serverDraftId == null) {
        throw const ApiException(
          UnknownFailure(
            message: 'Draft is still saving. Try again in a moment.',
          ),
        );
      }
      // Flush final edits (PATCH) ahead of the promote — the outbox is FIFO, so
      // the save_draft enqueued here is dispatched before send_draft below.
      await _upsertDraftMessage(
        db,
        localDraftId,
        req,
        attachments,
        serverDraftId: serverDraftId,
        serverDraftThreadId: _serverDraftThreadId(existingRow),
      );
      await _enqueueDraftSync(
        db,
        localDraftId,
        serverDraftId,
        req,
        attachments,
      );

      // Optimistically take it out of Drafts; the promoted server message
      // reconciles into Sent when send_draft flushes.
      await db.transaction(() async {
        await db.messageDao.deleteById(localDraftId);
        await db.threadDao.deleteByIdFolder(localDraftId, 'drafts');
      });
      await db.outboxDao.enqueue(
        operation: 'send_draft',
        payloadJson: jsonEncode({'serverDraftId': serverDraftId}),
      );
      _tryFlushOutbox();
    });
  }

  Future<void> undoLastSend() async {
    final outboxId = lastQueuedOutboxId;
    final localId = lastLocalMessageId;
    if (outboxId == null || localId == null) return;
    final db = ref.read(appDatabaseProvider);
    await db.outboxDao.discard(outboxId);
    await db.messageDao.deleteById(localId);
    // Remove the optimistic thread row created for a new composition.
    await db.threadDao.deleteByIdFolder(localId, 'sent');
    await db.threadDao.deleteByIdFolder(localId, 'scheduled');
    lastQueuedOutboxId = null;
    lastLocalMessageId = null;
  }

  Future<void> deleteDraft(String draftId) async {
    final db = ref.read(appDatabaseProvider);
    final serverDraftId = _serverDraftId(await db.messageDao.getById(draftId));
    await db.transaction(() async {
      await db.messageDao.deleteById(draftId);
      await db.threadDao.deleteByIdFolder(draftId, 'drafts');
    });
    // Drop any still-queued save so it can't recreate the draft we just removed.
    await _removePendingDraftSync(db, draftId);
    if (serverDraftId != null) {
      await db.outboxDao.enqueue(
        operation: 'delete_draft',
        payloadJson: jsonEncode({'serverDraftId': serverDraftId}),
      );
      _tryFlushOutbox();
    }
  }

  /// Kicks an immediate outbox flush, swallowing any failure (including the
  /// sync engine being unavailable, e.g. under test) — queued work still
  /// flushes later on reconnect.
  void _tryFlushOutbox() {
    try {
      unawaited(ref.read(syncEngineProvider).flushOutbox().catchError((_) {}));
    } catch (_) {}
  }

  /// Reads the server-assigned draft id previously stored in a local draft
  /// row's metadata (set by the sync engine after the first POST reconcile).
  String? _serverDraftId(MessageRow? row) =>
      _draftMetaString(row, 'server_draft_id');

  String? _serverDraftThreadId(MessageRow? row) =>
      _draftMetaString(row, 'server_draft_thread_id');

  String? _draftMetaString(MessageRow? row, String key) {
    if (row == null) return null;
    try {
      final metadata = jsonDecode(row.metadataJson) as Map<String, dynamic>;
      final value = metadata[key] as String?;
      return (value != null && value.isNotEmpty) ? value : null;
    } catch (_) {
      return null;
    }
  }

  /// Caches a draft authored on another device into the local store so it can
  /// be edited/sent here. [threadId] is the server draft's thread id (what the
  /// drafts list navigates with); the fetched message provides the fields and
  /// its attachments are kept as references (no downloadable bytes). Returns
  /// false if no draft message is found for the thread.
  Future<bool> cacheRemoteDraft(String threadId) async {
    final repo = ref.read(messageRepositoryProvider);
    final List<MailMessage> messages;
    try {
      messages = await repo.remote.getByThread(threadId);
    } catch (_) {
      return false;
    }
    final draft = messages.where((m) => m.status == 'draft').firstOrNull;
    if (draft == null) return false;

    final req = SendMessageRequest(
      mailboxId: draft.mailboxId,
      senderIdentityId: draft.metadata['sender_identity_id'] as String?,
      to: draft.toAddresses,
      cc: draft.ccAddresses,
      bcc: draft.bccAddresses,
      subject: draft.subject,
      bodyText: draft.bodyText,
      bodyHtml: draft.bodyHtml,
      scheduledAt: draft.scheduledAt,
    );
    final attachments = draft.attachments
        .map(
          (a) => ComposeAttachmentRequest(
            filename: a.filename,
            contentType: a.contentType,
            content: '',
            sizeBytes: a.sizeBytes,
            contentId: a.contentId,
            serverId: a.id,
          ),
        )
        .toList();

    await _upsertDraftMessage(
      repo.db,
      threadId,
      req,
      attachments,
      serverDraftId: draft.id,
      serverDraftThreadId: threadId,
    );
    return true;
  }

  Map<String, dynamic> _draftBody(
    SendMessageRequest req,
    List<ComposeAttachmentRequest> attachments,
  ) => {
    'mailbox': req.mailboxId,
    'sender_identity': ?req.senderIdentityId,
    'to': req.to.map((e) => {'email': e.email, 'name': e.name}).toList(),
    'cc': req.cc.map((e) => e.toJson()).toList(),
    'bcc': req.bcc.map((e) => e.toJson()).toList(),
    'subject': req.subject,
    'body_text': ?req.bodyText,
    'body_html': ?req.bodyHtml,
    'reply_to_message': ?req.replyToMessageId,
    'scheduled_at': ?req.scheduledAt?.toIso8601String(),
    // Full desired set every save: references keep already-staged attachments,
    // new ones carry base64. The draft endpoint reconciles against this list.
    'attachments': attachments.map((a) => a.toDraftPayload()).toList(),
  };

  /// Enqueues (or coalesces into an existing pending) draft sync op for
  /// [localId]. A draft with no server id yet is POSTed; one with a server id
  /// is PATCHed. Repeated saves before a flush replace the queued payload.
  Future<void> _enqueueDraftSync(
    AppDatabase db,
    String localId,
    String? serverDraftId,
    SendMessageRequest req,
    List<ComposeAttachmentRequest> attachments,
  ) async {
    final payloadJson = jsonEncode({
      'localId': localId,
      'serverDraftId': ?serverDraftId,
      'body': _draftBody(req, attachments),
    });
    final existing = await _findPendingDraftSync(db, localId);
    if (existing != null) {
      await db.outboxDao.updatePayload(existing.id, payloadJson);
    } else {
      await db.outboxDao.enqueue(
        operation: 'save_draft',
        payloadJson: payloadJson,
      );
    }
  }

  Future<OutboxEntry?> _findPendingDraftSync(
    AppDatabase db,
    String localId,
  ) async {
    final pending = await db.outboxDao.getPending();
    for (final entry in pending) {
      if (entry.operation != 'save_draft') continue;
      try {
        final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
        if (map['localId'] == localId) return entry;
      } catch (_) {}
    }
    return null;
  }

  Future<void> _removePendingDraftSync(AppDatabase db, String localId) async {
    final existing = await _findPendingDraftSync(db, localId);
    if (existing != null) await db.outboxDao.discard(existing.id);
  }

  /// Inserts a local `queued` row immediately so the message shows up in
  /// the thread/sent folder before the sync engine has reached the server.
  /// Replaced with the real server message once the outbox entry is sent.
  Future<void> _insertOptimisticMessage(
    AppDatabase db,
    String localId,
    SendMessageRequest req,
    List<ComposeAttachmentRequest> attachments, {
    required MailboxRow mailbox,
    required bool isScheduled,
  }) async {
    String? threadId;
    if (req.replyToMessageId != null) {
      final original = await db.messageDao.getById(req.replyToMessageId!);
      threadId = original?.threadId;
    }

    // A future-dated send lives in a scheduled view, not Sent, until it fires.
    final folder = isScheduled ? 'scheduled' : 'sent';
    final status = isScheduled ? 'scheduled' : 'queued';
    final now = DateTime.now().toUtc();
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
    final snippet = (req.bodyText ?? '').trim();

    await db.transaction(() async {
      await db.messageDao.upsertAll([
        MessagesCompanion.insert(
          id: localId,
          mailboxId: req.mailboxId,
          threadId: Value(threadId),
          direction: 'outbound',
          status: status,
          folder: Value(folder),
          fromAddress: mailbox.emailAddress,
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
          snippet: Value(snippet.isEmpty ? null : snippet),
          bodyText: Value(req.bodyText),
          bodyHtml: Value(req.bodyHtml),
          hasAttachments: Value(attachments.isNotEmpty),
          attachmentsJson: Value(jsonEncode(attachmentRows)),
          scheduledAt: Value(req.scheduledAt),
          createdAt: now,
        ),
      ]);

      // For a brand-new composition (no existing thread) the thread list binds
      // to the threads table, so without a row the sent/scheduled message would
      // be invisible until the server response reconciles. Mirror the draft path.
      if (threadId == null) {
        await db.threadDao.upsertAll([
          ThreadsCompanion.insert(
            id: localId,
            mailboxId: req.mailboxId,
            subject: req.subject.trim().isEmpty
                ? '(no subject)'
                : req.subject.trim(),
            messageCount: const Value(1),
            hasUnread: const Value(false),
            unreadCount: const Value(0),
            snippet: Value(snippet.isEmpty ? null : snippet),
            latestDirection: const Value('outbound'),
            hasAttachments: Value(attachments.isNotEmpty),
            attachmentFilenamesJson: Value(
              jsonEncode(attachments.map((a) => a.filename).toList()),
            ),
            participantsJson: Value(
              jsonEncode([
                if (req.to.isNotEmpty)
                  ...req.to.map((e) => e.email)
                else
                  mailbox.emailAddress,
              ]),
            ),
            folder: Value(folder),
            updatedAt: now,
            lastMessageAt: now,
          ),
        ]);
      }
    });
  }

  Future<void> _upsertDraftMessage(
    AppDatabase db,
    String localId,
    SendMessageRequest req,
    List<ComposeAttachmentRequest> attachments, {
    List<dynamic>? bodyDelta,
    bool htmlSourceMode = false,
    String? serverDraftId,
    String? serverDraftThreadId,
  }) async {
    final mailbox = await db.mailboxDao.getById(req.mailboxId);
    final now = DateTime.now().toUtc();
    final subject = req.subject.trim();
    final metadata = {
      if (req.senderIdentityId != null)
        'sender_identity_id': req.senderIdentityId,
      if (req.replyToMessageId != null)
        'reply_to_message_id': req.replyToMessageId,
      'server_draft_id': ?serverDraftId,
      'server_draft_thread_id': ?serverDraftThreadId,
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
