import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/sync/connectivity_watcher.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_engine.g.dart';

const int _maxRetries = 5;

/// Statuses past which a sent message will not transition further
/// ( message status enum); polling stops once one is reached.
const _terminalSendStatuses = {
  'sent',
  'delivered',
  'bounced',
  'opened',
  'clicked',
  'spam',
  'failed',
  'cancelled',
};

@Riverpod(keepAlive: true)
SyncEngine syncEngine(Ref ref) {
  final engine = SyncEngine(ref);
  ref.onDispose(engine.dispose);
  return engine;
}

class SyncEngine {
  SyncEngine(this._ref) {
    _connectivitySub = _ref.listen(isOnlineProvider, (_, next) {
      next.whenData((online) {
        if (online) flushOutbox();
      });
    });
    unawaited(_recoverStuckSending());
    unawaited(_resumePendingSendPolling());
    unawaited(_schedulePendingOutboxFlushes());
  }

  final Ref _ref;
  ProviderSubscription<AsyncValue<bool>>? _connectivitySub;
  final List<Timer> _scheduledFlushTimers = [];
  bool _flushing = false;

  void scheduleFlushAt(DateTime when) {
    final delay = when.toLocal().difference(DateTime.now());
    if (delay <= Duration.zero) {
      unawaited(flushOutbox());
      return;
    }
    late final Timer timer;
    timer = Timer(delay, () {
      _scheduledFlushTimers.remove(timer);
      unawaited(flushOutbox());
    });
    _scheduledFlushTimers.add(timer);
  }

  Future<void> flushOutbox() async {
    if (_flushing) return;
    _flushing = true;
    try {
      final db = _ref.read(appDatabaseProvider);
      final dio = _ref.read(dioClientProvider);
      final entries = await db.outboxDao.getPending();
      final now = DateTime.now();

      for (final entry in entries) {
        if (entry.retryCount >= _maxRetries) {
          await db.outboxDao.markDeadLetter(entry.id);
          continue;
        }

        // Skip entries that are in backoff: next retry is updatedAt + backoff
        // window, or the server-advertised Retry-After window if that's
        // later (set below when a dispatch fails with 429).
        final backoffEnd = entry.updatedAt.add(_backoff(entry.retryCount));
        final effectiveBackoffEnd =
            entry.retryAfterUntil != null &&
                entry.retryAfterUntil!.isAfter(backoffEnd)
            ? entry.retryAfterUntil!
            : backoffEnd;
        if (entry.retryCount > 0 && now.isBefore(effectiveBackoffEnd)) {
          continue;
        }

        final notBefore = _notBefore(entry);
        if (notBefore != null && now.isBefore(notBefore)) {
          scheduleFlushAt(notBefore);
          continue;
        }

        await db.outboxDao.markSending(entry.id);
        try {
          await _dispatch(dio, db, entry);
          await db.outboxDao.markDone(entry.id);
        } on DioException catch (e) {
          debugPrint(
            '[SyncEngine] dispatch failed (${entry.operation}): ${e.message}',
          );
          final retryCount = entry.retryCount + 1;
          final retryAfter = _retryAfterUntil(e);
          await db.outboxDao.markFailed(
            entry.id,
            e.message ?? e.toString(),
            retryCount,
            retryAfterUntil: retryAfter,
          );
          if (retryAfter != null && retryAfter.isAfter(DateTime.now())) {
            if (retryCount < _maxRetries) scheduleFlushAt(retryAfter);
          } else {
            _scheduleBackoffFlush(retryCount);
          }
        } catch (e) {
          debugPrint('[SyncEngine] dispatch error (${entry.operation}): $e');
          final retryCount = entry.retryCount + 1;
          await db.outboxDao.markFailed(entry.id, e.toString(), retryCount);
          _scheduleBackoffFlush(retryCount);
        }
      }
    } finally {
      _flushing = false;
    }
  }

  Future<void> _dispatch(Dio dio, AppDatabase db, OutboxEntry entry) async {
    switch (entry.operation) {
      case 'send_message':
        // Payload: {"localId": "<optimistic row id>", "body": {...}}
        final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
        final localId = map['localId'] as String?;
        final body = map['body'] as Map<String, dynamic>;
        final res = await dio.post('mail/messages/send/', data: body);
        // The POST above already succeeded server-side — the message was
        // sent (or queued to send). Everything from here is *local* cache
        // reconciliation, and a failure in it must never cause a retry: this
        // outbox entry stays `done` regardless, because retrying would
        // re-POST and double-send. If full reconciliation fails (unexpected
        // response shape, a local DB write error), fall back to just
        // deleting the optimistic `local-...` row instead of leaving it
        // permanently stuck — the real message reappears on the next
        // thread/mailbox refresh from the server, which is a brief gap, not
        // silent data loss or a stuck duplicate.
        try {
          final msg = MailMessage.fromJson(res.data as Map<String, dynamic>);
          await db.messageDao.upsertAll([messageToRow(msg)]);
          if (_isFutureScheduled(msg)) {
            await _upsertScheduledThread(db, msg);
          }
          if (localId != null) {
            await _dropOptimisticRow(db, localId);
          }
          if (!_terminalSendStatuses.contains(msg.status)) {
            unawaited(_pollSendStatus(msg.id));
          }
        } catch (e) {
          debugPrint(
            '[SyncEngine] reconcile error (send already succeeded '
            'server-side; dropping optimistic row, not retrying): $e',
          );
          if (localId != null) {
            try {
              await _dropOptimisticRow(db, localId);
            } catch (dropError) {
              debugPrint(
                '[SyncEngine] failed to drop optimistic row $localId '
                'after reconcile failure: $dropError',
              );
            }
          }
        }
      case 'state_change':
        // Payload: {"id": "<msgId>", "body": {...}}
        final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
        final id = map['id'] as String;
        final body = map['body'] as Map<String, dynamic>;
        await dio.patch('mail/messages/$id/state/', data: body);
      case 'save_draft':
        // Payload: {"localId": "<draft row id>", "serverDraftId"?: "...",
        //           "body": {...}}. First save POSTs and remembers the server
        //           id; later saves PATCH that same remote draft.
        final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
        final localId = map['localId'] as String?;
        // Resolve the server draft id at dispatch time rather than trusting the
        // payload: a save enqueued while an earlier save for the same draft was
        // in-flight (status 'sending', so not coalesced) carries a stale null
        // id. By the time it dispatches the first POST has reconciled the real
        // id into the local row's metadata; reading it here turns this save into
        // a PATCH instead of a second POST (which would duplicate the draft).
        final serverDraftId =
            (map['serverDraftId'] as String?) ??
            (localId == null ? null : await _resolveServerDraftId(db, localId));
        final body = map['body'] as Map<String, dynamic>;
        if (serverDraftId == null) {
          final res = await dio.post('mail/messages/draft/', data: body);
          final data = res.data as Map<String, dynamic>;
          final newId = data['id'] as String?;
          final threadId = data['thread'] as String?;
          if (localId != null && newId != null) {
            await _storeServerDraftId(dio, db, localId, newId, threadId);
          }
        } else {
          await dio.patch('mail/messages/$serverDraftId/draft/', data: body);
        }
      case 'send_draft':
        // Payload: {"serverDraftId": "..."}. Promotes a server draft into a
        // queued send (reusing its staged attachments) and reconciles the
        // resulting message into the local cache.
        final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
        final serverDraftId = map['serverDraftId'] as String?;
        if (serverDraftId != null) {
          final res = await dio.post(
            'mail/messages/$serverDraftId/send-draft/',
          );
          // As with send_message: the POST above already promoted the draft
          // to a queued send server-side. A failure below is a *local*
          // reconcile problem, not a reason to retry — retrying would hit
          // the draft-only `send-draft` endpoint on a message that's no
          // longer a draft. The local row is left stale (still shows
          // `draft`) rather than duplicated; it self-corrects on the next
          // thread/mailbox refresh.
          try {
            final msg = MailMessage.fromJson(res.data as Map<String, dynamic>);
            await db.messageDao.upsertAll([messageToRow(msg)]);
            if (!_terminalSendStatuses.contains(msg.status)) {
              unawaited(_pollSendStatus(msg.id));
            }
          } catch (e) {
            debugPrint(
              '[SyncEngine] send_draft reconcile error (send already '
              'succeeded server-side, not retrying): $e',
            );
          }
        }
      case 'delete_draft':
        // Payload: {"serverDraftId": "..."}
        final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
        final serverDraftId = map['serverDraftId'] as String?;
        if (serverDraftId != null) {
          try {
            await dio.delete('mail/messages/$serverDraftId/');
          } on DioException catch (e) {
            // Already gone server-side — nothing left to delete.
            if (e.response?.statusCode != 404) rethrow;
          }
        }
      default:
        debugPrint('[SyncEngine] unknown operation: ${entry.operation}');
    }
  }

  /// Removes the optimistic `local-...` placeholder row (and its scheduled
  /// composition thread rows, if any) for a message that's now confirmed
  /// sent server-side — used both on the reconcile happy path (replaced by
  /// the real server row) and on reconcile failure (nothing to replace it
  /// with locally yet; the real message reappears on the next server fetch).
  Future<void> _dropOptimisticRow(AppDatabase db, String localId) async {
    await db.messageDao.deleteById(localId);
    await db.threadDao.deleteByIdFolder(localId, 'sent');
    await db.threadDao.deleteByIdFolder(localId, 'scheduled');
  }

  bool _isFutureScheduled(MailMessage message) {
    final scheduledAt = message.scheduledAt;
    return message.direction == 'outbound' &&
        scheduledAt != null &&
        scheduledAt.isAfter(DateTime.now().toUtc()) &&
        ['queued', 'sending', 'scheduled'].contains(message.status);
  }

  Future<void> _upsertScheduledThread(
    AppDatabase db,
    MailMessage message,
  ) async {
    final threadId = message.threadId ?? message.id;
    final participants = [
      if (message.toAddresses.isNotEmpty)
        ...message.toAddresses.map((address) => address.email)
      else
        message.fromAddress,
    ];
    await db.threadDao.upsertAll([
      ThreadsCompanion.insert(
        id: threadId,
        mailboxId: message.mailboxId,
        subject: message.subject.trim().isEmpty
            ? '(no subject)'
            : message.subject.trim(),
        messageCount: const Value(1),
        hasUnread: const Value(false),
        unreadCount: const Value(0),
        snippet: Value(message.snippet),
        latestDirection: const Value('outbound'),
        hasAttachments: Value(message.hasAttachments),
        attachmentFilenamesJson: Value(
          jsonEncode(
            message.attachments
                .map((attachment) => attachment.filename)
                .toList(),
          ),
        ),
        participantsJson: Value(jsonEncode(participants)),
        folder: const Value('scheduled'),
        updatedAt: DateTime.now().toUtc(),
        lastMessageAt:
            message.scheduledAt ?? message.createdAt ?? DateTime.now().toUtc(),
      ),
    ]);
  }

  /// Records the server-assigned draft id on the local draft row so later
  /// saves PATCH it instead of creating a new one. If the local draft is
  /// already gone (sent or discarded before this reconcile landed), the freshly
  /// created server draft is orphaned, so delete it.
  Future<void> _storeServerDraftId(
    Dio dio,
    AppDatabase db,
    String localId,
    String serverId,
    String? serverThreadId,
  ) async {
    final row = await db.messageDao.getById(localId);
    if (row == null) {
      try {
        await dio.delete('mail/messages/$serverId/');
      } catch (_) {}
      return;
    }
    Map<String, dynamic> metadata;
    try {
      metadata = jsonDecode(row.metadataJson) as Map<String, dynamic>;
    } catch (_) {
      metadata = {};
    }
    metadata['server_draft_id'] = serverId;
    // The server draft's thread id lets the drafts list dedupe this local draft
    // against the same draft fetched from the server on another device.
    if (serverThreadId != null) {
      metadata['server_draft_thread_id'] = serverThreadId;
    }
    await db.messageDao.setMetadataJson(localId, jsonEncode(metadata));
  }

  /// Reads the server draft id reconciled onto a local draft row by an earlier
  /// [_storeServerDraftId]. Null until the first POST has landed.
  Future<String?> _resolveServerDraftId(AppDatabase db, String localId) async {
    final row = await db.messageDao.getById(localId);
    if (row == null) return null;
    try {
      final metadata = jsonDecode(row.metadataJson) as Map<String, dynamic>;
      final value = metadata['server_draft_id'] as String?;
      return (value != null && value.isNotEmpty) ? value : null;
    } catch (_) {
      return null;
    }
  }

  Duration _backoff(int attempt) {
    final seconds = min(pow(2, attempt).toInt(), 60);
    return Duration(seconds: seconds);
  }

  /// Parses a `429` response's `Retry-After` header (seconds, per DRF's
  /// throttle implementation) into an absolute retry time, or null if the
  /// failure wasn't a 429 or didn't carry a parseable header. Without this,
  /// the outbox's own retry loop could immediately re-hit the same
  /// throttled endpoint on its next exponential-backoff attempt.
  DateTime? _retryAfterUntil(DioException e) {
    if (e.response?.statusCode != 429) return null;
    final raw = e.response?.headers.value('retry-after');
    if (raw == null) return null;
    final seconds = int.tryParse(raw.trim());
    if (seconds == null) return null;
    return DateTime.now().add(Duration(seconds: seconds));
  }

  /// Without this, a failed entry only gets retried on the next connectivity
  /// change, new enqueue, or scheduled-send timer — it could otherwise sit
  /// unsynced well past its backoff window. Skipped once retries are
  /// exhausted since the entry will dead-letter on the next flush instead.
  void _scheduleBackoffFlush(int retryCount) {
    if (retryCount >= _maxRetries) return;
    scheduleFlushAt(DateTime.now().add(_backoff(retryCount)));
  }

  DateTime? _notBefore(OutboxEntry entry) {
    if (entry.operation != 'send_message') return null;
    try {
      final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
      final raw = map['notBefore'] as String?;
      if (raw == null) return null;
      return DateTime.parse(raw).toLocal();
    } catch (_) {
      return null;
    }
  }

  /// Rewinds any outbox entry orphaned in `sending` by a previous crash (the
  /// app died between `markSending` and `markDone`/`markFailed`) so it isn't
  /// stuck forever — `getPending` never surfaces `sending` rows again.
  Future<void> _recoverStuckSending() async {
    final db = _ref.read(appDatabaseProvider);
    await db.outboxDao.resetStuckSending();
  }

  Future<void> _schedulePendingOutboxFlushes() async {
    final db = _ref.read(appDatabaseProvider);
    final entries = await db.outboxDao.getPending();
    for (final entry in entries) {
      final notBefore = _notBefore(entry);
      if (notBefore != null) scheduleFlushAt(notBefore);
    }
  }

  /// Resumes polling for outbound messages still `queued`/`sending` from a
  /// previous app session (e.g. the app was closed mid-send).
  Future<void> _resumePendingSendPolling() async {
    final db = _ref.read(appDatabaseProvider);
    final rows = await db.messageDao.getByStatuses(['queued', 'sending']);
    for (final row in rows) {
      if (row.direction == 'outbound' && !row.id.startsWith('local-')) {
        unawaited(_pollSendStatus(row.id));
      }
    }
  }

  /// Re-runs status polling for a message the previous poll gave up on
  /// (`metadata['poll_timed_out']`) — wired to a "Check status" affordance
  /// in the UI so a stuck-looking `queued`/`sending` message isn't a dead
  /// end. A successful response on any attempt naturally clears the flag,
  /// since `messageToRow` overwrites local `metadata` with the server's
  /// (which never carries this client-only key).
  Future<void> retryPollSendStatus(String messageId) =>
      _pollSendStatus(messageId);

  /// Polls `GET /api/mail/messages/{id}/` until the send reaches a terminal
  /// status  (queued→sending→sent→delivered, or failed/bounced/
  /// cancelled), updating the local cache after each response.
  ///
  /// If the server hasn't reached a terminal status after all attempts (slow
  /// provider, retry storm), this doesn't just give up silently: it flags
  /// the local row with `metadata['poll_timed_out'] = true` so the UI can
  /// show something other than an indefinite "still sending" with a way to
  /// check again (`retryPollSendStatus`), instead of a dead end
  /// indistinguishable from actually-still-sending.
  Future<void> _pollSendStatus(String messageId) async {
    final db = _ref.read(appDatabaseProvider);
    final dio = _ref.read(dioClientProvider);
    var delay = const Duration(seconds: 2);

    for (var attempt = 0; attempt < 8; attempt++) {
      await Future.delayed(delay);
      try {
        final res = await dio.get('mail/messages/$messageId/');
        final msg = MailMessage.fromJson(res.data as Map<String, dynamic>);
        await db.messageDao.upsertAll([messageToRow(msg)]);
        if (_terminalSendStatuses.contains(msg.status)) return;
      } catch (e) {
        debugPrint('[SyncEngine] poll error for $messageId: $e');
      }
      delay = Duration(seconds: min(delay.inSeconds * 2, 30));
    }

    await _flagPollTimedOut(db, messageId);
  }

  Future<void> _flagPollTimedOut(AppDatabase db, String messageId) async {
    final row = await db.messageDao.getById(messageId);
    if (row == null) return;
    Map<String, dynamic> metadata;
    try {
      metadata = jsonDecode(row.metadataJson) as Map<String, dynamic>;
    } catch (_) {
      metadata = {};
    }
    metadata['poll_timed_out'] = true;
    await db.messageDao.setMetadataJson(messageId, jsonEncode(metadata));
  }

  void dispose() {
    _connectivitySub?.close();
    for (final timer in _scheduledFlushTimers) {
      timer.cancel();
    }
    _scheduledFlushTimers.clear();
  }
}
