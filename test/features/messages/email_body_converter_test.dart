import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/messages/presentation/utils/email_body_converter.dart';

void main() {
  group('email body conversion', () {
    test('loads plain text into a document and returns plain text', () {
      final document = emailDocumentFromBody(body: 'Hello team', isHtml: false);

      expect(emailPlainTextFromDocument(document), 'Hello team');
      expect(emailHtmlFromDocument(document), '<p>Hello team</p>');
    });

    test('renders inline formatting and links as email HTML', () {
      final delta = Delta()
        ..insert('Hello ')
        ..insert('team', {'bold': true})
        ..insert(' ')
        ..insert('site', {'link': 'https://example.com'})
        ..insert('\n');

      final html = emailHtmlFromDocument(Document.fromDelta(delta));

      expect(
        html,
        '<p>Hello <strong>team</strong> '
        '<a href="https://example.com">site</a></p>',
      );
    });

    test('renders bullet lists', () {
      final delta = Delta()
        ..insert('First')
        ..insert('\n', {'list': 'bullet'})
        ..insert('Second')
        ..insert('\n', {'list': 'bullet'});

      final html = emailHtmlFromDocument(Document.fromDelta(delta));

      expect(html, '<ul><li>First</li><li>Second</li></ul>');
    });

    test('creates plain text from html source', () {
      expect(
        plainTextFromHtml('<p>Hello <strong>team</strong></p><p>Next</p>'),
        'Hello team\nNext',
      );
    });
  });
}
