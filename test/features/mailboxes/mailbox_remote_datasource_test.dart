import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/mailboxes/data/datasources/mailbox_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  test(
    'getMailboxes fetches mail/mailboxes/ and unwraps the pagination envelope',
    () async {
      final dio = _MockDio();
      when(() => dio.get('mail/mailboxes/')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'count': 1,
            'next': null,
            'previous': null,
            'results': [
              {
                'id': 'mb1',
                'domain': 'domain1',
                'local_part': 'support',
                'email_address': 'support@example.test',
              },
            ],
          },
        ),
      );
      final datasource = MailboxRemoteDatasource(dio);

      final mailboxes = await datasource.getMailboxes();

      expect(mailboxes, hasLength(1));
      expect(mailboxes.single.id, 'mb1');
      expect(mailboxes.single.emailAddress, 'support@example.test');
    },
  );
}
