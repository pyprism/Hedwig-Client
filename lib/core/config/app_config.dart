import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

const String _kBaseUrlKey = 'base_url';

@Riverpod(keepAlive: true)
class AppConfig extends _$AppConfig {
  @override
  String? build() {
    final prefs = ref.watch(prefsStorageProvider);
    return prefs.getString(_kBaseUrlKey);
  }

  Future<void> setBaseUrl(String url) async {
    final normalizedUrl = url.trimRight().replaceAll(RegExp(r'/+$'), '');
    final prefs = ref.read(prefsStorageProvider);
    await prefs.setString(_kBaseUrlKey, normalizedUrl);
    state = normalizedUrl;
  }

  Future<void> clear() async {
    final prefs = ref.read(prefsStorageProvider);
    await prefs.remove(_kBaseUrlKey);
    state = null;
  }
}
