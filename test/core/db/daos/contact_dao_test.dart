import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/db/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('ContactDao', () {
    test(
      'watchByMailbox emits rows ordered by most recently contacted',
      () async {
        await db.contactDao.upsertAll([
          ContactsCompanion.insert(
            id: 'c1',
            mailboxId: 'mb1',
            email: 'older@example.test',
            updatedAt: DateTime.now().toUtc(),
            lastContactedAt: Value(DateTime.utc(2026, 1, 1)),
          ),
          ContactsCompanion.insert(
            id: 'c2',
            mailboxId: 'mb1',
            email: 'newer@example.test',
            updatedAt: DateTime.now().toUtc(),
            lastContactedAt: Value(DateTime.utc(2026, 6, 1)),
          ),
          ContactsCompanion.insert(
            id: 'c3',
            mailboxId: 'mb2',
            email: 'other-mailbox@example.test',
            updatedAt: DateTime.now().toUtc(),
          ),
        ]);

        final rows = await db.contactDao.watchByMailbox('mb1').first;

        expect(rows.map((r) => r.id), ['c2', 'c1']);
      },
    );

    test('upsertAll updates an existing contact in place', () async {
      await db.contactDao.upsertAll([
        ContactsCompanion.insert(
          id: 'c1',
          mailboxId: 'mb1',
          email: 'alice@example.test',
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);

      await db.contactDao.upsertAll([
        ContactsCompanion.insert(
          id: 'c1',
          mailboxId: 'mb1',
          email: 'alice@example.test',
          name: const Value('Alice'),
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);

      final rows = await db.contactDao.watchByMailbox('mb1').first;
      expect(rows, hasLength(1));
      expect(rows.single.name, 'Alice');
    });
  });
}
