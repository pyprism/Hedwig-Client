import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/token_pair.dart';

void main() {
  group('TokenPair.fromJson', () {
    test('parses docs/api.md token response sample', () {
      final json = {'access': '<jwt>', 'refresh': '<jwt>'};

      final pair = TokenPair.fromJson(json);

      expect(pair.access, '<jwt>');
      expect(pair.refresh, '<jwt>');
    });
  });
}
