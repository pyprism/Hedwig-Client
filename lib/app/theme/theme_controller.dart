import 'package:flutter/material.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

const _kThemeModeKey = 'theme_mode';

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() {
    final prefs = ref.watch(prefsStorageProvider);
    final stored = prefs.getString(_kThemeModeKey);
    return switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(prefsStorageProvider);
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString(_kThemeModeKey, value);
  }
}
