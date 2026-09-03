import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/threads/data/datasources/thread_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

Response<dynamic> _res(dynamic data) => Response(
  requestOptions: RequestOptions(path: ''),
  data: data,
);

Map<String, dynamic> _emptyPage() => {
  'count': 0,
  'next': null,
  'previous': null,
  'results': <dynamic>[],
};

void main() {
  late _MockDio dio;
  late ThreadRemoteDatasource datasource;

  setUp(() {
    dio = _MockDio();
    datasource = ThreadRemoteDatasource(dio);
    when(
      () => dio.get(
        'mail/threads/',
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => _res(_emptyPage()));
  });

  group('ThreadRemoteDatasource.getThreads', () {
    test('a plain folder sorts by that folder\'s latest message', () async {
      await datasource.getThreads(mailboxId: 'mb1', folder: 'inbox');

      verify(
        () => dio.get(
          'mail/threads/',
          queryParameters: {
            'mailbox': 'mb1',
            'folder': 'inbox',
            'ordering': '-folder_last_message_at',
            'page': 1,
            'page_size': 20,
          },
        ),
      ).called(1);
    });

    test('no folder sorts by the thread\'s global latest message', () async {
      await datasource.getThreads(mailboxId: 'mb1');

      verify(
        () => dio.get(
          'mail/threads/',
          queryParameters: {
            'mailbox': 'mb1',
            'ordering': '-last_message_at',
            'page': 1,
            'page_size': 20,
          },
        ),
      ).called(1);
    });

    test('a "label:" folder becomes a quoted label search term, not a folder filter', () async {
      await datasource.getThreads(mailboxId: 'mb1', folder: 'label:Work');

      verify(
        () => dio.get(
          'mail/threads/',
          queryParameters: {
            'mailbox': 'mb1',
            'search': 'label:"Work"',
            'ordering': '-last_message_at',
            'page': 1,
            'page_size': 20,
          },
        ),
      ).called(1);
    });

    test('a "label:" folder combines with free-text search', () async {
      await datasource.getThreads(
        mailboxId: 'mb1',
        folder: 'label:Work',
        search: 'invoice',
      );

      final call =
          verify(
                () => dio.get(
                  'mail/threads/',
                  queryParameters: captureAny(named: 'queryParameters'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(call['search'], 'label:"Work" invoice');
    });

    test('page and pageSize pass through', () async {
      await datasource.getThreads(mailboxId: 'mb1', page: 3, pageSize: 50);

      verify(
        () => dio.get(
          'mail/threads/',
          queryParameters: {
            'mailbox': 'mb1',
            'ordering': '-last_message_at',
            'page': 3,
            'page_size': 50,
          },
        ),
      ).called(1);
    });
  });

  group('ThreadRemoteDatasource.getCounts', () {
    test('maps folder counts and label unread counts', () async {
      when(
        () => dio.get(
          'mail/threads/counts/',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => _res({
          'folders': {'inbox': 5, 'sent': 0},
          'labels': [
            {'id': 'l1', 'name': 'Work', 'unread': 2, 'color': '#fff'},
          ],
        }),
      );

      final counts = await datasource.getCounts(mailboxId: 'mb1');

      expect(counts.folders, {'inbox': 5, 'sent': 0});
      expect(counts.labels.single.id, 'l1');
      expect(counts.labels.single.unread, 2);
    });

    test('defaults to empty collections when fields are missing', () async {
      when(
        () => dio.get(
          'mail/threads/counts/',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _res(<String, dynamic>{}));

      final counts = await datasource.getCounts(mailboxId: 'mb1');

      expect(counts.folders, isEmpty);
      expect(counts.labels, isEmpty);
    });
  });
}
