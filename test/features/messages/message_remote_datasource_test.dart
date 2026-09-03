import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

Response<dynamic> _res(dynamic data) => Response(
  requestOptions: RequestOptions(path: ''),
  data: data,
);

Map<String, dynamic> _messageJson(String id) => {
  'id': id,
  'mailbox': 'mb1',
  'direction': 'inbound',
  'status': 'received',
  'from_address': 'sender@example.test',
  'subject': 'Hello',
};

void main() {
  late _MockDio dio;
  late MessageRemoteDatasource datasource;

  setUp(() {
    dio = _MockDio();
    datasource = MessageRemoteDatasource(dio);
  });

  group('MessageRemoteDatasource', () {
    test('getByThread queries by thread id, ordered, page-sized', () async {
      when(
        () => dio.get(
          'mail/messages/',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => _res({
          'count': 1,
          'next': null,
          'previous': null,
          'results': [_messageJson('m1')],
        }),
      );

      final messages = await datasource.getByThread('t1');

      verify(
        () => dio.get(
          'mail/messages/',
          queryParameters: {
            'thread': 't1',
            'ordering': 'created_at',
            'page_size': 100,
          },
        ),
      ).called(1);
      expect(messages.single.id, 'm1');
    });

    test('cancel posts to the cancel action', () async {
      when(() => dio.post('mail/messages/m1/cancel/'))
          .thenAnswer((_) async => _res(null));

      await datasource.cancel('m1');

      verify(() => dio.post('mail/messages/m1/cancel/')).called(1);
    });

    test('restore posts to the restore action', () async {
      when(() => dio.post('mail/messages/m1/restore/'))
          .thenAnswer((_) async => _res(null));

      await datasource.restore('m1');

      verify(() => dio.post('mail/messages/m1/restore/')).called(1);
    });

    test('permanentDelete deletes the permanent-delete action', () async {
      when(() => dio.delete('mail/messages/m1/permanent-delete/'))
          .thenAnswer((_) async => _res(null));

      await datasource.permanentDelete('m1');

      verify(() => dio.delete('mail/messages/m1/permanent-delete/')).called(1);
    });

    test('getById fetches and parses a single message', () async {
      when(() => dio.get('mail/messages/m1/'))
          .thenAnswer((_) async => _res(_messageJson('m1')));

      final message = await datasource.getById('m1');

      expect(message.id, 'm1');
    });

    test('bulkState omits unset fields from the payload', () async {
      when(
        () => dio.post('mail/messages/bulk-state/', data: any(named: 'data')),
      ).thenAnswer((_) async => _res(null));

      await datasource.bulkState(['m1', 'm2'], isRead: true);

      final captured =
          verify(
                () => dio.post(
                  'mail/messages/bulk-state/',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured, {
        'ids': ['m1', 'm2'],
        'is_read': true,
      });
    });

    test('bulkState includes snoozedUntil as UTC ISO-8601', () async {
      when(
        () => dio.post('mail/messages/bulk-state/', data: any(named: 'data')),
      ).thenAnswer((_) async => _res(null));
      final until = DateTime.utc(2026, 1, 1, 12);

      await datasource.bulkState(['m1'], snoozedUntil: until);

      final captured =
          verify(
                () => dio.post(
                  'mail/messages/bulk-state/',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured['snoozed_until'], until.toIso8601String());
    });

    test('getAttachmentDownloadUrl returns the signed url', () async {
      when(
        () => dio.get('mail/attachments/a1/download/'),
      ).thenAnswer((_) async => _res({'url': 'https://cdn.example.test/a1'}));

      final url = await datasource.getAttachmentDownloadUrl('a1');

      expect(url, 'https://cdn.example.test/a1');
    });
  });
}
