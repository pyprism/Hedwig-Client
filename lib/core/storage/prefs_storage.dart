import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prefs_storage.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences prefsStorage(Ref ref) {
  throw UnimplementedError('Override via ProviderScope overrides in main.dart');
}
