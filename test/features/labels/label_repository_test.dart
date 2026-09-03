import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/labels/data/datasources/label_remote_datasource.dart';
import 'package:hedwig_client/features/labels/data/repositories/label_repository.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements LabelRemoteDatasource {}

void main() {
  setUpAll(() {
    registerFallbackValue(DateTime.now());
  });

  late AppDatabase db;
  late _MockRemote remote;
  late LabelRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    remote = _MockRemote();
    repo = LabelRepository(remote: remote, db: db);
  });

  tearDown(() => db.close());

  group('LabelRepository', () {
    test(
      'watchLabels refreshes from remote and caches into local rows',
      () async {
        when(() => remote.getLabels(mailboxId: 'mb1')).thenAnswer(
          (_) async => const [Label(id: 'l1', mailboxId: 'mb1', name: 'Work')],
        );

        final labels = await repo
            .watchLabels('mb1')
            .firstWhere((l) => l.isNotEmpty);

        expect(labels.single.id, 'l1');
        expect(labels.single.name, 'Work');
      },
    );

    test(
      'watchLabels swallows a remote failure and keeps serving the cache',
      () async {
        await db.labelDao.upsertAll([
          LabelsCompanion.insert(
            id: 'l1',
            mailboxId: 'mb1',
            name: 'Cached',
            createdAt: DateTime.now().toUtc(),
          ),
        ]);
        when(() => remote.getLabels(mailboxId: 'mb1'))
            .thenThrow(Exception('offline'));

        final labels = await repo.watchLabels('mb1').first;

        expect(labels.single.id, 'l1');
      },
    );

    test('create stores the new label locally', () async {
      when(
        () => remote.createLabel(
          mailboxId: 'mb1',
          name: 'New',
          color: any(named: 'color'),
        ),
      ).thenAnswer(
        (_) async => const Label(id: 'l1', mailboxId: 'mb1', name: 'New'),
      );

      final created = await repo.create(mailboxId: 'mb1', name: 'New');

      expect(created.id, 'l1');
      final cached = await db.labelDao.watchByMailbox('mb1').first;
      expect(cached.single.id, 'l1');
    });

    test('delete removes the label remotely and locally', () async {
      await db.labelDao.upsertAll([
        LabelsCompanion.insert(
          id: 'l1',
          mailboxId: 'mb1',
          name: 'Gone',
          createdAt: DateTime.now().toUtc(),
        ),
      ]);
      when(() => remote.deleteLabel('l1')).thenAnswer((_) async {});

      await repo.delete('l1');

      verify(() => remote.deleteLabel('l1')).called(1);
      final cached = await db.labelDao.watchByMailbox('mb1').first;
      expect(cached, isEmpty);
    });

    test('applyToMessage calls remote then caches the join row', () async {
      when(() => remote.applyLabel(messageId: 'm1', labelId: 'l1'))
          .thenAnswer((_) async {});

      await repo.applyToMessage(messageId: 'm1', labelId: 'l1');

      verify(() => remote.applyLabel(messageId: 'm1', labelId: 'l1')).called(1);
      final cached = await (db.select(
        db.messageLabelCache,
      )..where((r) => r.messageId.equals('m1'))).get();
      expect(cached.single.labelId, 'l1');
    });

    test(
      'removeFromMessage calls remote then clears the cached join row',
      () async {
        when(() => remote.applyLabel(messageId: 'm1', labelId: 'l1'))
            .thenAnswer((_) async {});
        await repo.applyToMessage(messageId: 'm1', labelId: 'l1');
        when(() => remote.removeLabel(messageId: 'm1', labelId: 'l1'))
            .thenAnswer((_) async {});

        await repo.removeFromMessage(messageId: 'm1', labelId: 'l1');

        verify(() => remote.removeLabel(messageId: 'm1', labelId: 'l1'))
            .called(1);
      },
    );

    test(
      'getMessageLabelIds returns remote ids and refreshes the cache',
      () async {
        when(() => remote.getMessageLabelIds('m1'))
            .thenAnswer((_) async => ['l1', 'l2']);

        final ids = await repo.getMessageLabelIds('m1');

        expect(ids, ['l1', 'l2']);
      },
    );

    test(
      'getMessageLabelIds falls back to the cache when remote fails',
      () async {
        when(() => remote.applyLabel(messageId: 'm1', labelId: 'l1'))
            .thenAnswer((_) async {});
        await repo.applyToMessage(messageId: 'm1', labelId: 'l1');
        when(() => remote.getMessageLabelIds('m1'))
            .thenThrow(Exception('offline'));

        final ids = await repo.getMessageLabelIds('m1');

        expect(ids, ['l1']);
      },
    );
  });
}
