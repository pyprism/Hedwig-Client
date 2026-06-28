import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'label_dao.g.dart';

@DriftAccessor(tables: [Labels])
class LabelDao extends DatabaseAccessor<AppDatabase> with _$LabelDaoMixin {
  LabelDao(super.db);

  Stream<List<LabelRow>> watchByMailbox(String mailboxId) =>
      (select(labels)
            ..where((l) => l.mailboxId.equals(mailboxId))
            ..orderBy([(l) => OrderingTerm.asc(l.name)]))
          .watch();

  Future<void> upsertAll(List<LabelsCompanion> rows) async {
    await batch((b) {
      b.insertAllOnConflictUpdate(labels, rows);
    });
  }

  Future<void> deleteLabel(String id) async {
    await (delete(labels)..where((l) => l.id.equals(id))).go();
  }
}
