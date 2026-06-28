import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/settings/presentation/screens/rules_screen.dart';

void main() {
  group('mailbox rule API contract', () {
    test('uses the backend mailbox-rules path', () {
      expect(mailboxRulesPath, 'mail/mailbox-rules/');
    });

    test('builds backend-shaped conditions and actions maps', () {
      final payload = mailboxRulePayload(
        mailboxId: 'mb1',
        name: 'Archive invoices',
        conditionField: 'subject_contains',
        conditionValue: 'invoice',
        actionType: 'move_to_folder',
        actionValue: 'archive',
      );

      expect(payload, {
        'mailbox': 'mb1',
        'name': 'Archive invoices',
        'conditions': {'subject_contains': 'invoice'},
        'actions': {'move_to_folder': 'archive'},
        'is_active': true,
      });
    });

    test('uses a boolean value for has_attachment conditions', () {
      final payload = mailboxRulePayload(
        mailboxId: 'mb1',
        name: 'Attachment label',
        conditionField: 'has_attachment',
        conditionValue: '',
        actionType: 'add_label',
        actionValue: 'Files',
      );

      expect(payload['conditions'], {'has_attachment': true});
      expect(payload['actions'], {'add_label': 'Files'});
    });
  });
}
