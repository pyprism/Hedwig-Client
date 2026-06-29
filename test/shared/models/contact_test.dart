import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/contact.dart';

void main() {
  group('Contact.fromJson', () {
    test('parses docs/api.md contact field set (snake_case)', () {
      final json = {
        'id': 'c1',
        'mailbox': 'mb1',
        'email': 'client@example.com',
        'name': 'Client',
        'is_favorite': true,
        'times_contacted': 5,
        'last_contacted_at': '2026-06-16T09:00:00Z',
        'updated_at': '2026-06-16T09:30:00Z',
      };

      final contact = Contact.fromJson(json);

      expect(contact.id, 'c1');
      expect(
        contact.mailboxId,
        'mb1',
        reason: 'API field is bare "mailbox", model maps to mailboxId',
      );
      expect(contact.email, 'client@example.com');
      expect(contact.name, 'Client');
      expect(contact.isFavorite, isTrue);
      expect(contact.timesContacted, 5);
      expect(contact.lastContactedAt, DateTime.parse('2026-06-16T09:00:00Z'));
      expect(contact.updatedAt, DateTime.parse('2026-06-16T09:30:00Z'));
    });
  });
}
