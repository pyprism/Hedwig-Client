import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/thread.dart';

void main() {
  group('MailThread.fromJson', () {
    test('parses docs/api.md thread field set (snake_case)', () {
      final json = {
        'id': 'th1',
        'mailbox': 'mb1',
        'subject': 'Need help',
        'normalized_subject': 'need help',
        'root_message_id': 'msg1',
        'participants': ['bob@example.com', 'support@acme.com'],
        'message_count': 3,
        'has_unread': true,
        'last_message_at': '2026-06-16T09:00:00Z',
        'created_at': '2026-06-15T09:00:00Z',
      };

      final thread = MailThread.fromJson(json);

      expect(thread.id, 'th1');
      expect(
        thread.mailboxId,
        'mb1',
        reason: 'API field is bare "mailbox", model maps to mailboxId',
      );
      expect(thread.subject, 'Need help');
      expect(thread.participants, ['bob@example.com', 'support@acme.com']);
      expect(thread.messageCount, 3);
      expect(thread.hasUnread, isTrue);
      expect(thread.lastMessageAt, DateTime.parse('2026-06-16T09:00:00Z'));
      expect(thread.createdAt, DateTime.parse('2026-06-15T09:00:00Z'));
    });
  });
}
