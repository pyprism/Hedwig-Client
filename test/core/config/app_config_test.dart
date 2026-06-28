import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/config/app_config.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppConfig', () {
    late ProviderContainer container;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [prefsStorageProvider.overrideWithValue(prefs)],
      );
    });

    tearDown(() => container.dispose());

    test('starts with no base URL when preferences are empty', () {
      expect(container.read(appConfigProvider), isNull);
    });

    test('loads an existing base URL from preferences', () async {
      await prefs.setString('base_url', 'https://api.example.test');

      final seeded = ProviderContainer(
        overrides: [prefsStorageProvider.overrideWithValue(prefs)],
      );
      addTearDown(seeded.dispose);

      expect(seeded.read(appConfigProvider), 'https://api.example.test');
    });

    test('setBaseUrl trims whitespace and trailing slashes', () async {
      await container
          .read(appConfigProvider.notifier)
          .setBaseUrl('https://api.example.test///   ');

      expect(container.read(appConfigProvider), 'https://api.example.test');
      expect(prefs.getString('base_url'), 'https://api.example.test');
    });

    test('clear removes the persisted base URL', () async {
      await container
          .read(appConfigProvider.notifier)
          .setBaseUrl('https://api.example.test');

      await container.read(appConfigProvider.notifier).clear();

      expect(container.read(appConfigProvider), isNull);
      expect(prefs.getString('base_url'), isNull);
    });
  });
}
