import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/mailboxes/data/repositories/mailbox_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

Response<dynamic> _res(dynamic data) => Response(
  requestOptions: RequestOptions(path: ''),
  data: data,
);

Map<String, dynamic> _mailboxJson(String id) => {
  'id': id,
  'domain': 'domain1',
  'local_part': 'support',
  'email_address': 'support@example.test',
};

void main() {
  late AppDatabase db;
  late _MockDio dio;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dio = _MockDio();
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        dioClientProvider.overrideWithValue(dio),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    db.close();
  });

  group('MailboxRepository', () {
    test('watchMailboxes waits for the first successful remote fetch when the cache is empty', () async {
      when(() => dio.get('mail/mailboxes/')).thenAnswer(
        (_) async => _res({
          'count': 1,
          'next': null,
          'previous': null,
          'results': [_mailboxJson('mb1')],
        }),
      );

      final repo = container.read(mailboxRepositoryProvider);
      final mailboxes = await repo.watchMailboxes().firstWhere(
        (m) => m.isNotEmpty,
      );

      expect(mailboxes.single.id, 'mb1');
    });

    test(
      'watchMailboxes serves the cache immediately when it is non-empty',
      () async {
        await db.mailboxDao.upsertAll([
          MailboxesCompanion.insert(
            id: 'mb1',
            domainId: 'domain1',
            localPart: 'support',
            emailAddress: 'support@example.test',
            updatedAt: DateTime.now().toUtc(),
          ),
        ]);
        when(() => dio.get('mail/mailboxes/'))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final repo = container.read(mailboxRepositoryProvider);
        final mailboxes = await repo.watchMailboxes().first;

        expect(mailboxes.single.id, 'mb1');
      },
    );

    test('watchMailboxes surfaces an error when the cache is empty and the fetch fails', () async {
      when(() => dio.get('mail/mailboxes/'))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final repo = container.read(mailboxRepositoryProvider);

      await expectLater(repo.watchMailboxes(), emitsError(isA<DioException>()));
    });
  });
}
