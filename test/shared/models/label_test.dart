import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/label.dart';

void main() {
  group('Label.fromJson', () {
    test('parses docs/api.md label field set (snake_case)', () {
      final json = {
        'id': 'l1',
        'mailbox': 'mb1',
        'name': 'Finance',
        'color': '#ff0000',
        'created_at': '2026-06-16T09:00:00Z',
      };

      final label = Label.fromJson(json);

      expect(label.id, 'l1');
      expect(label.mailboxId, 'mb1', reason: 'API field is bare "mailbox", model maps to mailboxId');
      expect(label.name, 'Finance');
      expect(label.color, '#ff0000');
      expect(label.createdAt, DateTime.parse('2026-06-16T09:00:00Z'));
    });
  });
}
