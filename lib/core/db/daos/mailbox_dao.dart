import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'mailbox_dao.g.dart';

@DriftAccessor(tables: [Mailboxes])
class MailboxDao extends DatabaseAccessor<AppDatabase> with _$MailboxDaoMixin {
  MailboxDao(super.db);

  Stream<List<MailboxRow>> watchAll() => select(mailboxes).watch();

  Future<List<MailboxRow>> getAll() => select(mailboxes).get();

  Future<MailboxRow?> getById(String id) =>
      (select(mailboxes)..where((m) => m.id.equals(id))).getSingleOrNull();

  Future<void> upsertAll(List<MailboxesCompanion> rows) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(mailboxes, rows);
    });
  }

  Future<void> deleteAll() => delete(mailboxes).go();
}
