import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/message.dart';

void main() {
  group('MailMessage.fromJson', () {
    test('parses docs/api.md message read object sample', () {
      final json = {
        'id': 'm1',
        'mailbox': 'mb1',
        'thread': 'th1',
        'direction': 'inbound',
        'status': 'received',
        'folder': 'inbox',
        'from_address': 'bob@example.com',
        'from_name': 'Bob',
        'to_addresses': [
          {'email': 'support@acme.com', 'name': ''},
        ],
        'cc_addresses': <Map<String, dynamic>>[],
        'subject': 'Need help',
        'snippet': 'Hi, I ...',
        'body_text': '...',
        'body_html': '...',
        'is_read': false,
        'is_starred': false,
        'has_attachments': true,
        'received_at': '2026-06-16T09:00:00Z',
        'attachments': [
          {
            'id': 'a1',
            'filename': 'invoice.pdf',
            'content_type': 'application/pdf',
            'size_bytes': 20480,
            'file': 'https://example.com/invoice.pdf',
            'is_inline': false,
          },
        ],
      };

      final message = MailMessage.fromJson(json);

      expect(message.id, 'm1');
      expect(message.mailboxId, 'mb1', reason: 'API field is bare "mailbox", model maps to mailboxId');
      expect(message.threadId, 'th1', reason: 'API field is bare "thread", model maps to threadId');
      expect(message.direction, 'inbound');
      expect(message.status, 'received');
      expect(message.folder, 'inbox');
      expect(message.fromAddress, 'bob@example.com');
      expect(message.fromName, 'Bob');
      expect(message.toAddresses, [const EmailAddress(email: 'support@acme.com')]);
      expect(message.subject, 'Need help');
      expect(message.snippet, 'Hi, I ...');
      expect(message.isRead, isFalse);
      expect(message.isStarred, isFalse);
      expect(message.hasAttachments, isTrue);
      expect(message.receivedAt, DateTime.parse('2026-06-16T09:00:00Z'));
      expect(message.attachments, hasLength(1));
      expect(message.attachments.single.filename, 'invoice.pdf');
      expect(message.attachments.single.contentType, 'application/pdf');
      expect(message.attachments.single.sizeBytes, 20480);
      expect(message.attachments.single.isInline, isFalse);
    });

    test('is_staff-style boolean fields are not silently dropped when true', () {
      final json = {
        'id': 'm1',
        'mailbox': 'mb1',
        'direction': 'outbound',
        'status': 'queued',
        'from_address': 'support@acme.com',
        'subject': 'Re: Need help',
        'is_read': true,
        'is_starred': true,
        'has_attachments': true,
      };

      final message = MailMessage.fromJson(json);

      expect(message.isRead, isTrue);
      expect(message.isStarred, isTrue);
      expect(message.hasAttachments, isTrue);
    });

    test('Attachment.fromJson parses content_id for inline images', () {
      final json = {
        'id': 'a2',
        'filename': 'logo.png',
        'content_type': 'image/png',
        'size_bytes': 512,
        'is_inline': true,
        'content_id': '<logo123@acme.com>',
      };

      final attachment = Attachment.fromJson(json);

      expect(attachment.isInline, isTrue);
      expect(attachment.contentId, '<logo123@acme.com>');
    });
  });
}
