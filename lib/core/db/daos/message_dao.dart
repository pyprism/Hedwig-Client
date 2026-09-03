import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'message_dao.g.dart';

@DriftAccessor(tables: [Messages])
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
  MessageDao(super.db);

  Stream<List<MessageRow>> watchByThread(String threadId) {
    final query = select(messages)
      ..where(
        (m) => threadId.startsWith('local-')
            ? (m.threadId.equals(threadId) | m.id.equals(threadId))
            : m.threadId.equals(threadId),
      )
      ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]);
    return query.watch();
  }

  Future<List<MessageRow>> getByThread(String threadId) {
    final query = select(messages)
      ..where(
        (m) => threadId.startsWith('local-')
            ? (m.threadId.equals(threadId) | m.id.equals(threadId))
            : m.threadId.equals(threadId),
      )
      ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]);
    return query.get();
  }

  Future<int> countByThreadFolder(String threadId, String folder) async {
    final count = messages.id.count();
    final query = selectOnly(messages)
      ..addColumns([count])
      ..where(
        messages.threadId.equals(threadId) & messages.folder.equals(folder),
      );
    return await query.map((row) => row.read(count) ?? 0).getSingle();
  }

  Future<MessageRow?> getById(String id) =>
      (select(messages)..where((m) => m.id.equals(id))).getSingleOrNull();

  Future<List<MessageRow>> getByIds(List<String> ids) {
    if (ids.isEmpty) return Future.value(const []);
    return (select(messages)..where((m) => m.id.isIn(ids))).get();
  }

  Future<List<MessageRow>> getByStatuses(List<String> statuses) =>
      (select(messages)..where((m) => m.status.isIn(statuses))).get();

  Future<void> deleteById(String id) =>
      (delete(messages)..where((m) => m.id.equals(id))).go();

  Stream<List<MessageRow>> watchByMailboxFolder(
    String mailboxId,
    String folder,
  ) =>
      (select(messages)
            ..where(
              (m) => m.mailboxId.equals(mailboxId) & m.folder.equals(folder),
            )
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
          .watch();

  Future<void> upsertAll(List<MessagesCompanion> rows) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(messages, rows);
    });
  }

  /// Locally-authored drafts (id `draft-%`) for a mailbox. Their metadata may
  /// carry a `server_draft_thread_id` used to dedupe the same draft when it is
  /// also fetched from the server (cross-device).
  Future<List<MessageRow>> getLocalDraftMessages(String mailboxId) =>
      (select(messages)..where(
            (m) =>
                m.mailboxId.equals(mailboxId) &
                m.status.equals('draft') &
                m.id.like('draft-%'),
          ))
          .get();

  Future<void> setMetadataJson(String id, String metadataJson) =>
      (update(messages)..where((m) => m.id.equals(id))).write(
        MessagesCompanion(metadataJson: Value(metadataJson)),
      );

  Future<void> updateState(
    String id, {
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
  }) => (update(messages)..where((m) => m.id.equals(id))).write(
    MessagesCompanion(
      isRead: isRead != null ? Value(isRead) : const Value.absent(),
      isStarred: isStarred != null ? Value(isStarred) : const Value.absent(),
      isImportant: isImportant != null
          ? Value(isImportant)
          : const Value.absent(),
      folder: folder != null ? Value(folder) : const Value.absent(),
    ),
  );

  /// Same as [updateState] but applies to every id in one statement, so a
  /// bulk action (e.g. trashing a multi-select of threads) issues a single
  /// write instead of one round-trip per message.
  Future<void> updateStatesBulk(
    List<String> ids, {
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
  }) {
    if (ids.isEmpty) return Future.value();
    return (update(messages)..where((m) => m.id.isIn(ids))).write(
      MessagesCompanion(
        isRead: isRead != null ? Value(isRead) : const Value.absent(),
        isStarred: isStarred != null ? Value(isStarred) : const Value.absent(),
        isImportant: isImportant != null
            ? Value(isImportant)
            : const Value.absent(),
        folder: folder != null ? Value(folder) : const Value.absent(),
      ),
    );
  }
}
