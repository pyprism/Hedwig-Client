import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/compose_controller.dart';

void main() {
  group('ComposeAttachmentRequest', () {
    test('serializes to the backend send attachment shape', () {
      const attachment = ComposeAttachmentRequest(
        filename: 'invoice.pdf',
        contentType: 'application/pdf',
        content: 'SGVkd2ln',
        sizeBytes: 6,
      );

      expect(attachment.toPayload(), {
        'filename': 'invoice.pdf',
        'content_type': 'application/pdf',
        'content': 'SGVkd2ln',
      });
    });

    test('includes content_id for inline image attachments', () {
      const attachment = ComposeAttachmentRequest(
        filename: 'logo.png',
        contentType: 'image/png',
        content: 'SGVkd2ln',
        sizeBytes: 6,
        contentId: 'logo@hedwig',
      );

      expect(attachment.toPayload(), {
        'filename': 'logo.png',
        'content_type': 'image/png',
        'content': 'SGVkd2ln',
        'content_id': 'logo@hedwig',
      });
    });
  });
}
