// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compose_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ComposeController)
final composeControllerProvider = ComposeControllerProvider._();

final class ComposeControllerProvider
    extends $NotifierProvider<ComposeController, AsyncValue<void>> {
  ComposeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'composeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$composeControllerHash();

  @$internal
  @override
  ComposeController create() => ComposeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$composeControllerHash() => r'57eecaa3a24d676872b9dba4e19dd77a555691c1';

abstract class _$ComposeController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
