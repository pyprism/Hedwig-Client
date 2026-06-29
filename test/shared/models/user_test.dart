import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/shared/models/user.dart';

void main() {
  group('HedwigUser.fromJson', () {
    test('parses docs/api.md "Current user" sample', () {
      final json = {
        'id': '0a1b...',
        'username': 'alice',
        'email': 'alice@example.com',
        'display_name': 'Alice',
        'avatar_url': null,
        'timezone': 'Asia/Kolkata',
        'locale': 'en',
        'must_change_password': false,
        'is_staff': true,
        'last_seen_at': '2026-06-16T10:29:00Z',
      };

      final user = HedwigUser.fromJson(json);

      expect(user.id, '0a1b...');
      expect(user.username, 'alice');
      expect(user.email, 'alice@example.com');
      expect(user.displayName, 'Alice');
      expect(user.avatarUrl, isNull);
      expect(user.timezone, 'Asia/Kolkata');
      expect(user.locale, 'en');
      expect(user.mustChangePassword, isFalse);
      expect(user.isStaff, isTrue);
      expect(user.lastSeenAt, DateTime.parse('2026-06-16T10:29:00Z'));
    });

    test('parses docs/api.md register response sample', () {
      final json = {
        'id': '0a1b...',
        'username': 'alice',
        'email': 'alice@example.com',
        'display_name': 'Alice',
        'is_staff': true,
        'is_superuser': true,
        'must_change_password': false,
        'created_at': '2026-06-16T10:00:00Z',
      };

      final user = HedwigUser.fromJson(json);

      expect(user.isStaff, isTrue);
      expect(user.isSuperuser, isTrue);
      expect(user.mustChangePassword, isFalse);
      expect(user.createdAt, DateTime.parse('2026-06-16T10:00:00Z'));
    });

    test('must_change_password=true is not silently dropped', () {
      final json = {
        'id': 'u1',
        'username': 'bob',
        'email': 'bob@example.com',
        'must_change_password': true,
        'is_staff': false,
      };

      final user = HedwigUser.fromJson(json);

      expect(user.mustChangePassword, isTrue);
    });

    test('first_name/last_name round-trip', () {
      final json = {
        'id': 'u1',
        'username': 'bob',
        'email': 'bob@example.com',
        'first_name': 'Bob',
        'last_name': 'Smith',
      };

      final user = HedwigUser.fromJson(json);

      expect(user.firstName, 'Bob');
      expect(user.lastName, 'Smith');
    });
  });
}
