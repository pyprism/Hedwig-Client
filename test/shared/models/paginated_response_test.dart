import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';

void main() {
  group('PaginatedResponse.fromJson', () {
    test('parses docs/api.md pagination envelope {count,next,previous,results}', () {
      final json = {
        'count': 2,
        'next': 'https://api.example.com/api/mail/labels/?page=2',
        'previous': null,
        'results': [
          {'id': 'l1', 'mailbox': 'mb1', 'name': 'Finance'},
          {'id': 'l2', 'mailbox': 'mb1', 'name': 'Urgent'},
        ],
      };

      final page = PaginatedResponse.fromJson(
        json,
        (j) => Label.fromJson(j as Map<String, dynamic>),
      );

      expect(page.count, 2);
      expect(page.next, 'https://api.example.com/api/mail/labels/?page=2');
      expect(page.previous, isNull);
      expect(page.results, hasLength(2));
      expect(page.results.first.name, 'Finance');
      expect(page.results.first.mailboxId, 'mb1');
    });
  });
}
