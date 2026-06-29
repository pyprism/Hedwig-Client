import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
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
    unawaited(_resumePendingSendPolling());
  }

  final Ref _ref;
  ProviderSubscription<AsyncValue<bool>>? _connectivitySub;
  bool _flushing = false;

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

        // Skip entries that are in backoff: next retry is updatedAt + backoff window.
        final backoffEnd = entry.updatedAt.add(_backoff(entry.retryCount));
        if (entry.retryCount > 0 && now.isBefore(backoffEnd)) continue;

        if (_notReadyToSend(entry, now)) continue;

        await db.outboxDao.markSending(entry.id);
        try {
          await _dispatch(dio, db, entry);
          await db.outboxDao.markDone(entry.id);
        } on DioException catch (e) {
          debugPrint(
            '[SyncEngine] dispatch failed (${entry.operation}): ${e.message}',
          );
          await db.outboxDao.markFailed(
            entry.id,
            e.message ?? e.toString(),
            entry.retryCount + 1,
          );
        } catch (e) {
          debugPrint('[SyncEngine] dispatch error (${entry.operation}): $e');
          await db.outboxDao.markFailed(
            entry.id,
            e.toString(),
            entry.retryCount + 1,
          );
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
        // Reconcile: replace the optimistic local row with the server-assigned message.
        try {
          final msg = MailMessage.fromJson(res.data as Map<String, dynamic>);
          await db.messageDao.upsertAll([messageToRow(msg)]);
          if (localId != null) {
            await db.messageDao.deleteById(localId);
            // Drop the optimistic thread row created for a new composition; the
            // reconciled server message carries the real thread.
            await db.threadDao.deleteByIdFolder(localId, 'sent');
            await db.threadDao.deleteByIdFolder(localId, 'scheduled');
          }
          if (!_terminalSendStatuses.contains(msg.status)) {
            unawaited(_pollSendStatus(msg.id));
          }
        } catch (e) {
          debugPrint('[SyncEngine] reconcile error: $e');
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
          try {
            final msg = MailMessage.fromJson(res.data as Map<String, dynamic>);
            await db.messageDao.upsertAll([messageToRow(msg)]);
            if (!_terminalSendStatuses.contains(msg.status)) {
              unawaited(_pollSendStatus(msg.id));
            }
          } catch (e) {
            debugPrint('[SyncEngine] send_draft reconcile error: $e');
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

  bool _notReadyToSend(OutboxEntry entry, DateTime now) {
    if (entry.operation != 'send_message') return false;
    try {
      final map = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
      final raw = map['notBefore'] as String?;
      if (raw == null) return false;
      final notBefore = DateTime.parse(raw).toLocal();
      return now.isBefore(notBefore);
    } catch (_) {
      return false;
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

  /// Polls `GET /api/mail/messages/{id}/` until the send reaches a terminal
  /// status  (queued→sending→sent→delivered, or failed/bounced/
  /// cancelled), updating the local cache after each response.
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
  }

  void dispose() {
    _connectivitySub?.close();
  }
}
