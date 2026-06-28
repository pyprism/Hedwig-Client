import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/threads/data/datasources/thread_remote_datasource.dart';
import 'package:hedwig_client/shared/models/thread.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_repository.g.dart';

@Riverpod(keepAlive: true)
ThreadRepository threadRepository(Ref ref) {
  return ThreadRepository(
    remote: ThreadRemoteDatasource(ref.watch(dioClientProvider)),
    db: ref.watch(appDatabaseProvider),
  );
}

@riverpod
Future<ThreadCounts> threadCounts(Ref ref, String mailboxId) {
  return ref
      .watch(threadRepositoryProvider)
      .remote
      .getCounts(mailboxId: mailboxId);
}

/// The threads endpoint is folder-aware: `?folder=` returns the threads with a
/// message in that folder (per-user state honoured) and folder-scoped
/// count/unread/last aggregates. The cache mirrors that per (mailbox, folder).
class ThreadRepository {
  const ThreadRepository({required this.remote, required this.db});

  static const _liveRefreshInterval = Duration(seconds: 20);

  final ThreadRemoteDatasource remote;
  final AppDatabase db;

  Stream<List<MailThread>> watchThreads({
    required String mailboxId,
    String folder = 'inbox',
    String? search,
  }) {
    if (search != null && search.trim().isNotEmpty) {
      return Stream.fromFuture(
        remote
            .getThreads(
              mailboxId: mailboxId,
              folder: folder,
              search: search,
              page: 1,
              pageSize: 50,
            )
            .then((page) => page.results),
      );
    }

    // Local-first: emit cached rows immediately, then keep the open mailbox
    // warm so inbound webhooks appear without a browser refresh.
    final cached = db.threadDao
        .watchByMailboxFolder(mailboxId, folder)
        .map((rows) => rows.map(_rowToModel).toList());

    return Stream.multi((controller) {
      var refreshing = false;
      Future<void> refresh() async {
        if (refreshing) return;
        refreshing = true;
        try {
          await _refresh(
            mailboxId: mailboxId,
            folder: folder,
            search: search,
            page: 1,
            replace: true,
          );
        } catch (e) {
          debugPrint('[ThreadRepository] refresh error: $e');
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

  Future<void> fetchNextPage({
    required String mailboxId,
    required String folder,
    required int page,
    String? search,
  }) async {
    if (search != null && search.trim().isNotEmpty) return;
    try {
      await _refresh(
        mailboxId: mailboxId,
        folder: folder,
        search: search,
        page: page,
        replace: false,
      );
    } catch (e) {
      debugPrint('[ThreadRepository] fetchNextPage error: $e');
    }
  }

  Future<void> _refresh({
    required String mailboxId,
    required String folder,
    String? search,
    required int page,
    required bool replace,
  }) async {
    final res = await remote.getThreads(
      mailboxId: mailboxId,
      folder: folder,
      search: search,
      page: page,
      pageSize: 50,
    );
    final companions = res.results.map((t) => _modelToRow(t, folder)).toList();

    await db.transaction(() async {
      // On a fresh load (page 1) clear the folder so threads that left it
      // disappear; subsequent pages append.
      if (replace) {
        await db.threadDao.deleteByMailboxFolder(mailboxId, folder);
      }
      if (companions.isNotEmpty) {
        await db.threadDao.upsertAll(companions);
      }
    });
  }

  MailThread _rowToModel(ThreadRow r) => MailThread(
    id: r.id,
    mailboxId: r.mailboxId,
    subject: r.subject,
    messageCount: r.messageCount,
    hasUnread: r.hasUnread,
    unreadCount: r.unreadCount,
    snippet: r.snippet,
    latestDirection: r.latestDirection,
    hasAttachments: r.hasAttachments,
    attachmentFilenames: _decodeStringList(r.attachmentFilenamesJson),
    labels: _decodeLabels(r.labelsJson),
    searchHighlight: r.searchHighlight,
    lastMessageAt: r.lastMessageAt,
    participants: (jsonDecode(r.participantsJson) as List).cast<String>(),
  );

  ThreadsCompanion _modelToRow(MailThread t, String folder) =>
      ThreadsCompanion.insert(
        id: t.id,
        mailboxId: t.mailboxId,
        subject: t.subject,
        messageCount: Value(t.messageCount),
        hasUnread: Value(t.hasUnread),
        unreadCount: Value(t.unreadCount),
        snippet: Value(t.snippet),
        latestDirection: Value(t.latestDirection),
        hasAttachments: Value(t.hasAttachments),
        attachmentFilenamesJson: Value(jsonEncode(t.attachmentFilenames)),
        labelsJson: Value(jsonEncode(t.labels.map((e) => e.toJson()).toList())),
        searchHighlight: Value(t.searchHighlight),
        lastMessageAt: t.lastMessageAt ?? DateTime.now().toUtc(),
        participantsJson: Value(jsonEncode(t.participants)),
        folder: Value(folder),
        updatedAt: DateTime.now().toUtc(),
      );

  List<String> _decodeStringList(String json) {
    try {
      return (jsonDecode(json) as List).cast<String>();
    } catch (_) {
      return [];
    }
  }

  List<ThreadLabel> _decodeLabels(String json) {
    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => ThreadLabel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
