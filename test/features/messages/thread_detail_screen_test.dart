import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/messages/presentation/screens/thread_detail_screen.dart';
import 'package:hedwig_client/shared/models/message.dart';

void main() {
  group('findAttachmentByContentId', () {
    const inlineAttachment = Attachment(
      id: 'a1',
      filename: 'logo.png',
      contentType: 'image/png',
      isInline: true,
      contentId: 'cid:logo123@acme.com',
    );

    test('matches attachment content IDs that include a cid prefix', () {
      final match = findAttachmentByContentId(const [
        inlineAttachment,
      ], 'logo123@acme.com');

      expect(match, inlineAttachment);
    });

    test('matches angle-bracketed and encoded cid values from HTML', () {
      final match = findAttachmentByContentId(const [
        inlineAttachment,
      ], '%3Clogo123@acme.com%3E');

      expect(match, inlineAttachment);
    });
  });

  group('isDownloadableAttachment', () {
    const inlineAttachment = Attachment(
      id: 'a1',
      filename: 'statement.pdf',
      contentType: 'application/pdf',
      isInline: true,
      contentId: 'statement-123@example.com',
    );

    test('shows inline-flagged attachments that are not embedded in HTML', () {
      expect(
        isDownloadableAttachment(
          inlineAttachment,
          '<p>Please see the attached statement.</p>',
        ),
        isTrue,
      );
    });

    test('hides inline attachments rendered through cid HTML references', () {
      expect(
        isDownloadableAttachment(
          inlineAttachment.copyWith(
            filename: 'logo.png',
            contentType: 'image/png',
          ),
          '<img src="cid:statement-123@example.com">',
        ),
        isFalse,
      );
    });
  });
}
