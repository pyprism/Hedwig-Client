import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/error/failure.dart';

void main() {
  group('Failure.userMessage', () {
    test('network failure mentions no connection', () {
      const f = Failure.network(message: 'timeout');
      expect(f.userMessage, contains('No connection'));
    });

    test('auth failure returns session message', () {
      const f = Failure.auth();
      expect(f.userMessage, isNotEmpty);
    });

    test('server failure returns non-empty message', () {
      const f = Failure.server(statusCode: 429, message: 'Rate limited');
      expect(f.userMessage, isNotEmpty);
    });

    test('notFound failure returns user message', () {
      const f = Failure.notFound();
      expect(f.userMessage, isNotEmpty);
    });

    test('unknown failure echoes message', () {
      const f = Failure.unknown(message: 'Something went wrong');
      expect(f.userMessage, contains('Something went wrong'));
    });
  });
}
