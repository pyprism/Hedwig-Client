import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';

void main() {
  group('Mailbox.fromJson', () {
    test('parses docs/api.md mailbox field set (snake_case)', () {
      final json = {
        'id': 'mb1',
        'domain': 'dom1',
        'local_part': 'support',
        'email_address': 'support@acme.com',
        'display_name': 'Support',
        'is_catch_all': false,
        'forward_to': '',
        'reply_to': '',
        'send_enabled': true,
        'receive_enabled': true,
        'quota_bytes': 0,
        'used_bytes': 1024,
        'signature_html': '<p>Thanks</p>',
        'signature_text': 'Thanks',
        'provider_sender_id': 'ps1',
        'metadata': {},
        'is_active': true,
        'updated_at': '2026-06-16T10:00:00Z',
      };

      final mailbox = Mailbox.fromJson(json);

      expect(mailbox.id, 'mb1');
      expect(
        mailbox.domainId,
        'dom1',
        reason: 'API field is bare "domain", model maps to domainId',
      );
      expect(mailbox.localPart, 'support');
      expect(mailbox.emailAddress, 'support@acme.com');
      expect(mailbox.displayName, 'Support');
      expect(mailbox.sendEnabled, isTrue);
      expect(mailbox.receiveEnabled, isTrue);
      expect(mailbox.isActive, isTrue);
      expect(mailbox.signatureHtml, '<p>Thanks</p>');
      expect(mailbox.signatureText, 'Thanks');
      expect(mailbox.updatedAt, DateTime.parse('2026-06-16T10:00:00Z'));
    });

    test(
      'required non-null fields throw if missing rather than silently null',
      () {
        final json = {
          'id': 'mb1',
          'domain': 'dom1',
          'local_part': 'support',
          // email_address intentionally omitted
        };

        expect(() => Mailbox.fromJson(json), throwsA(isA<TypeError>()));
      },
    );
  });
}
