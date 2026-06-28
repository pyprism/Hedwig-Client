import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hedwig_client/app/app.dart';
import 'package:hedwig_client/core/platform/file_picker_registration.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:hedwig_client/core/sync/sync_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) usePathUrlStrategy();
  ensureFilePickerRegistered();

  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [prefsStorageProvider.overrideWithValue(prefs)],
  );

  // Boot sync engine so it starts listening for connectivity changes.
  container.read(syncEngineProvider);

  runApp(
    UncontrolledProviderScope(container: container, child: const HedwigApp()),
  );
}
