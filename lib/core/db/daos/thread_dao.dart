import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'thread_dao.g.dart';

@DriftAccessor(tables: [Threads])
class ThreadDao extends DatabaseAccessor<AppDatabase> with _$ThreadDaoMixin {
  ThreadDao(super.db);

  Stream<List<ThreadRow>> watchByMailboxFolder(
    String mailboxId,
    String folder,
  ) =>
      (select(threads)
            ..where(
              (t) => t.mailboxId.equals(mailboxId) & t.folder.equals(folder),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
          .watch();

  Future<ThreadRow?> getByIdFolder(String threadId, String folder) =>
      (select(threads)
            ..where((t) => t.id.equals(threadId) & t.folder.equals(folder)))
          .getSingleOrNull();

  Future<List<ThreadRow>> getLocalDrafts(String mailboxId) =>
      (select(threads)..where(
            (t) =>
                t.mailboxId.equals(mailboxId) &
                t.folder.equals('drafts') &
                t.id.like('draft-%'),
          ))
          .get();

  Future<void> upsertAll(List<ThreadsCompanion> rows) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(threads, rows);
    });
  }

  Future<void> deleteByMailboxFolder(String mailboxId, String folder) =>
      (delete(threads)..where(
            (t) => t.mailboxId.equals(mailboxId) & t.folder.equals(folder),
          ))
          .go();

  Future<void> deleteByIdFolder(String threadId, String folder) => (delete(
    threads,
  )..where((t) => t.id.equals(threadId) & t.folder.equals(folder))).go();

  Future<void> updateUnread(
    String threadId, {
    required bool hasUnread,
    required int unreadCount,
  }) => (update(threads)..where((t) => t.id.equals(threadId))).write(
    ThreadsCompanion(
      hasUnread: Value(hasUnread),
      unreadCount: Value(unreadCount),
      updatedAt: Value(DateTime.now().toUtc()),
    ),
  );

  Future<void> deleteAll() => delete(threads).go();
}
