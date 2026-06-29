// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'density_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Message list density ('compact' | 'comfortable' | 'relaxed'), persisted to
/// prefs. Reactive so changing it in Settings updates the thread list live.

@ProviderFor(MessageDensity)
final messageDensityProvider = MessageDensityProvider._();

/// Message list density ('compact' | 'comfortable' | 'relaxed'), persisted to
/// prefs. Reactive so changing it in Settings updates the thread list live.
final class MessageDensityProvider
    extends $NotifierProvider<MessageDensity, String> {
  /// Message list density ('compact' | 'comfortable' | 'relaxed'), persisted to
  /// prefs. Reactive so changing it in Settings updates the thread list live.
  MessageDensityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messageDensityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messageDensityHash();

  @$internal
  @override
  MessageDensity create() => MessageDensity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$messageDensityHash() => r'c35c68c50ed603184fad700507618c4a5ad4785b';

/// Message list density ('compact' | 'comfortable' | 'relaxed'), persisted to
/// prefs. Reactive so changing it in Settings updates the thread list live.

abstract class _$MessageDensity extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
