import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/app/theme/theme_controller.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeController', () {
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

    test('defaults to system theme when no preference is stored', () {
      expect(container.read(themeControllerProvider), ThemeMode.system);
    });

    test('loads stored dark preference', () async {
      await prefs.setString('theme_mode', 'dark');

      final seeded = ProviderContainer(
        overrides: [prefsStorageProvider.overrideWithValue(prefs)],
      );
      addTearDown(seeded.dispose);

      expect(seeded.read(themeControllerProvider), ThemeMode.dark);
    });

    test('persists light, dark, and system modes', () async {
      final controller = container.read(themeControllerProvider.notifier);

      await controller.setMode(ThemeMode.light);
      expect(container.read(themeControllerProvider), ThemeMode.light);
      expect(prefs.getString('theme_mode'), 'light');

      await controller.setMode(ThemeMode.dark);
      expect(container.read(themeControllerProvider), ThemeMode.dark);
      expect(prefs.getString('theme_mode'), 'dark');

      await controller.setMode(ThemeMode.system);
      expect(container.read(themeControllerProvider), ThemeMode.system);
      expect(prefs.getString('theme_mode'), 'system');
    });
  });
}
