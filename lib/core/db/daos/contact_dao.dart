import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  ContactDao(super.db);

  Stream<List<ContactRow>> watchByMailbox(String mailboxId) =>
      (select(contacts)
            ..where((c) => c.mailboxId.equals(mailboxId))
            ..orderBy([(c) => OrderingTerm.desc(c.lastContactedAt)]))
          .watch();

  Future<void> upsertAll(List<ContactsCompanion> rows) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(contacts, rows);
    });
  }
}
