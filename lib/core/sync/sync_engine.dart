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
      default:
        debugPrint('[SyncEngine] unknown operation: ${entry.operation}');
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
