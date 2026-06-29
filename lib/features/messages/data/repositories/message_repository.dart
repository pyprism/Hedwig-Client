import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_repository.g.dart';

/// Maps a [MailMessage] to its local row representation. Shared by
/// [MessageRepository] (server-fetched messages) and [SyncEngine]
/// (reconciling the message returned by a successful send).
MessagesCompanion messageToRow(MailMessage m) => MessagesCompanion.insert(
  id: m.id,
  mailboxId: m.mailboxId,
  threadId: Value(m.threadId),
  direction: m.direction,
  status: m.status,
  folder: Value(m.folder),
  fromAddress: m.fromAddress,
  fromName: Value(m.fromName),
  envelopeSender: Value(m.envelopeSender),
  envelopeRecipient: Value(m.envelopeRecipient),
  toAddressesJson: Value(
    jsonEncode(m.toAddresses.map((e) => e.toJson()).toList()),
  ),
  ccAddressesJson: Value(
    jsonEncode(m.ccAddresses.map((e) => e.toJson()).toList()),
  ),
  bccAddressesJson: Value(
    jsonEncode(m.bccAddresses.map((e) => e.toJson()).toList()),
  ),
  replyTo: Value(m.replyTo),
  subject: m.subject,
  snippet: Value(m.snippet),
  bodyText: Value(m.bodyText),
  bodyHtml: Value(m.bodyHtml),
  rawMimeUrl: Value(m.rawMimeUrl),
  isRead: Value(m.isRead),
  isStarred: Value(m.isStarred),
  hasAttachments: Value(m.hasAttachments),
  attachmentsJson: Value(
    jsonEncode(m.attachments.map((a) => a.toJson()).toList()),
  ),
  rawHeadersJson: Value(jsonEncode(m.rawHeaders)),
  metadataJson: Value(jsonEncode(m.metadata)),
  receivedAt: Value(m.receivedAt),
  sentAt: Value(m.sentAt),
  scheduledAt: Value(m.scheduledAt),
  createdAt: m.createdAt ?? DateTime.now().toUtc(),
);

@Riverpod(keepAlive: true)
MessageRepository messageRepository(Ref ref) {
  return MessageRepository(
    remote: MessageRemoteDatasource(ref.watch(dioClientProvider)),
    db: ref.watch(appDatabaseProvider),
  );
}

class MessageRepository {
  const MessageRepository({required this.remote, required this.db});

  static const _liveRefreshInterval = Duration(seconds: 20);

  final MessageRemoteDatasource remote;
  final AppDatabase db;

  Stream<List<MailMessage>> watchThread(String threadId) {
    final cached = db.messageDao
        .watchByThread(threadId)
        .map((rows) => rows.map(_rowToModel).toList());

    return Stream.multi((controller) {
      var refreshing = false;
      Future<void> refresh() async {
        if (refreshing) return;
        refreshing = true;
        try {
          await _refreshThread(threadId);
        } finally {
          refreshing = false;
        }
      }

      unawaited(refresh());
      final timer = Timer.periodic(
        _liveRefreshInterval,
        (_) => unawaited(refresh()),
      );
      final subscription = cached.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
      controller.onCancel = () {
        timer.cancel();
        return subscription.cancel();
      };
    });
  }

  Future<List<MailMessage>> getThreadMessages(String threadId) async {
    final messages = await remote.getByThread(threadId);
    await db.messageDao.upsertAll(messages.map(messageToRow).toList());
    return messages;
  }

  Future<void> _refreshThread(String threadId) async {
    try {
      final messages = await remote.getByThread(threadId);
      await db.messageDao.upsertAll(messages.map(messageToRow).toList());
    } catch (e) {
      debugPrint('[MessageRepository] refresh error: $e');
    }
  }

  Future<void> updateState(
    String id, {
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
    DateTime? snoozedUntil,
  }) async {
    final previous = folder == null ? null : await db.messageDao.getById(id);

    // Optimistic local update first.
    await db.messageDao.updateState(
      id,
      isRead: isRead,
      isStarred: isStarred,
      folder: folder,
    );
    if (folder != null && previous != null) {
      await _syncThreadFolderCache(previous, folder);
    }
    await _cacheUserState(
      id,
      isRead: isRead,
      isStarred: isStarred,
      isImportant: isImportant,
      folder: folder,
      snoozedUntil: snoozedUntil,
    );

    final payload = _statePayload(
      isRead: isRead,
      isStarred: isStarred,
      isImportant: isImportant,
      folder: folder,
      snoozedUntil: snoozedUntil,
    );
    try {
      await remote.bulkState(
        [id],
        isRead: isRead,
        isStarred: isStarred,
        isImportant: isImportant,
        folder: folder,
        snoozedUntil: snoozedUntil,
      );
    } catch (e) {
      debugPrint('[MessageRepository] state update queued: $e');
      await _enqueueStateChange(id, payload);
    }
  }

  Future<void> markThreadRead(String threadId) async {
    var rows = await db.messageDao.getByThread(threadId);
    if (rows.isEmpty) {
      await getThreadMessages(threadId);
      rows = await db.messageDao.getByThread(threadId);
    }
    final ids = rows.map((row) => row.id).toList();
    if (ids.isEmpty) return;

    await db.transaction(() async {
      for (final id in ids) {
        await db.messageDao.updateState(id, isRead: true);
        await _cacheUserState(id, isRead: true);
      }
      await db.threadDao.updateUnread(
        threadId,
        hasUnread: false,
        unreadCount: 0,
      );
    });

    try {
      await remote.bulkState(ids, isRead: true);
    } catch (e) {
      debugPrint('[MessageRepository] thread read update queued: $e');
      final payload = _statePayload(isRead: true);
      for (final id in ids) {
        await _enqueueStateChange(id, payload);
      }
    }
  }

  Map<String, dynamic> _statePayload({
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
    DateTime? snoozedUntil,
  }) => {
    'is_read': ?isRead,
    'is_starred': ?isStarred,
    'is_important': ?isImportant,
    'folder': ?folder,
    'snoozed_until': ?snoozedUntil?.toIso8601String(),
  };

  Future<void> _enqueueStateChange(String id, Map<String, dynamic> payload) =>
      db.outboxDao.enqueue(
        operation: 'state_change',
        payloadJson: jsonEncode({'id': id, 'body': payload}),
      );

  Future<String> getAttachmentDownloadUrl(String attachmentId) =>
      remote.getAttachmentDownloadUrl(attachmentId);

  Future<void> bulkUpdateState(
    List<String> ids, {
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
    DateTime? snoozedUntil,
  }) async {
    if (ids.isEmpty) return;
    final previousRows = <MessageRow>[];
    if (folder != null) {
      for (final id in ids) {
        final previous = await db.messageDao.getById(id);
        if (previous != null) previousRows.add(previous);
      }
    }
    for (final id in ids) {
      await db.messageDao.updateState(
        id,
        isRead: isRead,
        isStarred: isStarred,
        folder: folder,
      );
      await _cacheUserState(
        id,
        isRead: isRead,
        isStarred: isStarred,
        isImportant: isImportant,
        folder: folder,
        snoozedUntil: snoozedUntil,
      );
    }
    if (folder != null) {
      for (final previous in previousRows) {
        await _syncThreadFolderCache(previous, folder);
      }
    }

    final payload = _statePayload(
      isRead: isRead,
      isStarred: isStarred,
      isImportant: isImportant,
      folder: folder,
      snoozedUntil: snoozedUntil,
    );
    try {
      await remote.bulkState(
        ids,
        isRead: isRead,
        isStarred: isStarred,
        isImportant: isImportant,
        folder: folder,
        snoozedUntil: snoozedUntil,
      );
    } catch (e) {
      // Offline-safe: the optimistic local write already happened, so queue
      // one state_change per id for the sync engine to flush on reconnect.
      debugPrint('[MessageRepository] bulk state update queued: $e');
      for (final id in ids) {
        await _enqueueStateChange(id, payload);
      }
    }
  }

  /// Cancels a pending scheduled send. Requires connectivity — unlike other
  /// writes this isn't outbox-queued, since the schedule fires server-side
  /// independent of the client (`docs/api.md`: outbound+queued with a
  /// pending attempt only).
  Future<void> cancelScheduledSend(String messageId) async {
    await remote.cancel(messageId);
    final msg = await remote.getById(messageId);
    await db.messageDao.upsertAll([messageToRow(msg)]);
  }

  Future<void> restore(String messageId) async {
    final previous = await db.messageDao.getById(messageId);

    // Optimistic local update first (restore == per-user folder state change).
    await db.messageDao.updateState(messageId, folder: 'inbox');
    if (previous != null) {
      await _syncThreadFolderCache(previous, 'inbox');
    }
    await _cacheUserState(messageId, folder: 'inbox', deletedAt: null);

    try {
      await remote.restore(messageId);
    } catch (e) {
      // Offline-safe: queue the folder change so the sync engine reconciles it.
      debugPrint('[MessageRepository] restore queued: $e');
      await _enqueueStateChange(messageId, _statePayload(folder: 'inbox'));
    }
  }

  Future<void> _syncThreadFolderCache(
    MessageRow previous,
    String nextFolder,
  ) async {
    final threadId = previous.threadId;
    if (threadId == null || previous.folder == nextFolder) return;

    final sourceThread = await db.threadDao.getByIdFolder(
      threadId,
      previous.folder,
    );
    final remainingInPreviousFolder = await db.messageDao.countByThreadFolder(
      threadId,
      previous.folder,
    );
    if (remainingInPreviousFolder == 0) {
      await db.threadDao.deleteByIdFolder(threadId, previous.folder);
    }

    final existingDestination = await db.threadDao.getByIdFolder(
      threadId,
      nextFolder,
    );
    if (existingDestination != null) return;

    await db.threadDao.upsertAll([
      ThreadsCompanion.insert(
        id: threadId,
        mailboxId: previous.mailboxId,
        subject: sourceThread?.subject ?? previous.subject,
        messageCount: const Value(1),
        hasUnread: Value(!previous.isRead),
        unreadCount: Value(previous.isRead ? 0 : 1),
        snippet: Value(previous.snippet),
        latestDirection: Value(previous.direction),
        hasAttachments: Value(previous.hasAttachments),
        attachmentFilenamesJson: Value(
          sourceThread?.attachmentFilenamesJson ?? jsonEncode([]),
        ),
        labelsJson: Value(sourceThread?.labelsJson ?? jsonEncode([])),
        searchHighlight: Value(sourceThread?.searchHighlight),
        lastMessageAt: previous.createdAt,
        participantsJson: Value(
          sourceThread?.participantsJson ??
              jsonEncode([previous.fromName ?? previous.fromAddress]),
        ),
        folder: Value(nextFolder),
        updatedAt: DateTime.now().toUtc(),
      ),
    ]);
  }

  Future<void> permanentDelete(String messageId) async {
    // Permanent delete can't be deferred to the outbox (it's a hard server
    // delete), so surface a typed Failure when offline instead of a raw throw.
    try {
      await remote.permanentDelete(messageId);
    } on DioException catch (e) {
      throw ApiException(failureFromError(e.error ?? e));
    }
    await db.messageDao.deleteById(messageId);
    await (db.delete(
      db.messageUserStates,
    )..where((row) => row.messageId.equals(messageId))).go();
  }

  Future<void> _cacheUserState(
    String messageId, {
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
    DateTime? snoozedUntil,
    DateTime? archivedAt,
    DateTime? deletedAt,
  }) async {
    final existing = await (db.select(
      db.messageUserStates,
    )..where((row) => row.messageId.equals(messageId))).getSingleOrNull();
    await db
        .into(db.messageUserStates)
        .insertOnConflictUpdate(
          MessageUserStatesCompanion.insert(
            messageId: messageId,
            folder: Value(folder ?? existing?.folder ?? 'inbox'),
            isRead: Value(isRead ?? existing?.isRead ?? false),
            isStarred: Value(isStarred ?? existing?.isStarred ?? false),
            isImportant: Value(isImportant ?? existing?.isImportant ?? false),
            snoozedUntil: Value(snoozedUntil ?? existing?.snoozedUntil),
            archivedAt: Value(archivedAt ?? existing?.archivedAt),
            deletedAt: Value(deletedAt ?? existing?.deletedAt),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  MailMessage _rowToModel(MessageRow r) => MailMessage(
    id: r.id,
    mailboxId: r.mailboxId,
    threadId: r.threadId,
    direction: r.direction,
    status: r.status,
    folder: r.folder,
    fromAddress: r.fromAddress,
    fromName: r.fromName,
    envelopeSender: r.envelopeSender,
    envelopeRecipient: r.envelopeRecipient,
    toAddresses: _decodeAddresses(r.toAddressesJson),
    ccAddresses: _decodeAddresses(r.ccAddressesJson),
    bccAddresses: _decodeAddresses(r.bccAddressesJson),
    replyTo: r.replyTo,
    subject: r.subject,
    snippet: r.snippet,
    bodyText: r.bodyText,
    bodyHtml: r.bodyHtml,
    rawMimeUrl: r.rawMimeUrl,
    isRead: r.isRead,
    isStarred: r.isStarred,
    hasAttachments: r.hasAttachments,
    attachments: _decodeAttachments(r.attachmentsJson),
    rawHeaders: _decodeMap(r.rawHeadersJson),
    metadata: _decodeMap(r.metadataJson),
    receivedAt: r.receivedAt,
    sentAt: r.sentAt,
    scheduledAt: r.scheduledAt,
    createdAt: r.createdAt,
  );

  List<EmailAddress> _decodeAddresses(String json) {
    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  List<Attachment> _decodeAttachments(String json) {
    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Map<String, dynamic> _decodeMap(String json) {
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}
