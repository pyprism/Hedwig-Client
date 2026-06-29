import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'density_controller.g.dart';

const messageDensityPreferenceKey = 'message_density';
const _validDensities = {'compact', 'comfortable', 'relaxed'};

/// Message list density ('compact' | 'comfortable' | 'relaxed'), persisted to
/// prefs. Reactive so changing it in Settings updates the thread list live.
@Riverpod(keepAlive: true)
class MessageDensity extends _$MessageDensity {
  @override
  String build() {
    final prefs = ref.watch(prefsStorageProvider);
    final stored = prefs.getString(messageDensityPreferenceKey);
    return _validDensities.contains(stored) ? stored! : 'comfortable';
  }

  Future<void> setDensity(String value) async {
    if (!_validDensities.contains(value)) return;
    state = value;
    await ref
        .read(prefsStorageProvider)
        .setString(messageDensityPreferenceKey, value);
  }
}
