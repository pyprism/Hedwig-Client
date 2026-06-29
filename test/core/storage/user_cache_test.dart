import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hedwig_client/core/storage/user_cache.dart';
import 'package:hedwig_client/shared/models/user.dart';

void main() {
  group('UserCache', () {
    late SharedPreferences prefs;
    late UserCache cache;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      cache = UserCache(prefs);
    });

    test('save then load returns same user', () async {
      const user = HedwigUser(
        id: 'u1',
        username: 'alice',
        email: 'alice@test.com',
        isStaff: false,
      );
      await cache.save(user);
      final loaded = cache.load();
      expect(loaded, isNotNull);
      expect(loaded!.id, 'u1');
      expect(loaded.username, 'alice');
      expect(loaded.email, 'alice@test.com');
    });

    test('load returns null when empty', () {
      expect(cache.load(), isNull);
    });

    test('clear removes stored user', () async {
      const user = HedwigUser(id: 'u2', username: 'bob', email: 'bob@test.com');
      await cache.save(user);
      await cache.clear();
      expect(cache.load(), isNull);
    });

    test('staff flag preserved through cache', () async {
      const user = HedwigUser(
        id: 'u3',
        username: 'admin',
        email: 'admin@test.com',
        isStaff: true,
        isSuperuser: true,
      );
      await cache.save(user);
      final loaded = cache.load();
      expect(loaded?.isStaff, isTrue);
      expect(loaded?.isSuperuser, isTrue);
    });
  });
}
