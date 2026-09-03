import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/db/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('LabelDao', () {
    test('watchByMailbox emits rows for the mailbox ordered by name', () async {
      await db.labelDao.upsertAll([
        LabelsCompanion.insert(
          id: 'l1',
          mailboxId: 'mb1',
          name: 'Zebra',
          createdAt: DateTime.now().toUtc(),
        ),
        LabelsCompanion.insert(
          id: 'l2',
          mailboxId: 'mb1',
          name: 'Alpha',
          createdAt: DateTime.now().toUtc(),
        ),
        LabelsCompanion.insert(
          id: 'l3',
          mailboxId: 'mb2',
          name: 'Other mailbox',
          createdAt: DateTime.now().toUtc(),
        ),
      ]);

      final rows = await db.labelDao.watchByMailbox('mb1').first;

      expect(rows.map((r) => r.id), ['l2', 'l1']);
    });

    test('deleteLabel removes only the targeted row', () async {
      await db.labelDao.upsertAll([
        LabelsCompanion.insert(
          id: 'l1',
          mailboxId: 'mb1',
          name: 'Keep',
          createdAt: DateTime.now().toUtc(),
        ),
        LabelsCompanion.insert(
          id: 'l2',
          mailboxId: 'mb1',
          name: 'Remove',
          createdAt: DateTime.now().toUtc(),
        ),
      ]);

      await db.labelDao.deleteLabel('l2');

      final rows = await db.labelDao.watchByMailbox('mb1').first;
      expect(rows.map((r) => r.id), ['l1']);
    });
  });
}
