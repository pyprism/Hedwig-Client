// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(labelList)
final labelListProvider = LabelListFamily._();

final class LabelListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Label>>,
          List<Label>,
          Stream<List<Label>>
        >
    with $FutureModifier<List<Label>>, $StreamProvider<List<Label>> {
  LabelListProvider._({
    required LabelListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'labelListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labelListHash();

  @override
  String toString() {
    return r'labelListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Label>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Label>> create(Ref ref) {
    final argument = this.argument as String;
    return labelList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabelListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labelListHash() => r'3c62daf8f9c342e95319e91c3853f09764b6c67a';

final class LabelListFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Label>>, String> {
  LabelListFamily._()
    : super(
        retry: null,
        name: r'labelListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabelListProvider call(String mailboxId) =>
      LabelListProvider._(argument: mailboxId, from: this);

  @override
  String toString() => r'labelListProvider';
}

@ProviderFor(LabelActions)
final labelActionsProvider = LabelActionsProvider._();

final class LabelActionsProvider
    extends $NotifierProvider<LabelActions, AsyncValue<void>> {
  LabelActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelActionsHash();

  @$internal
  @override
  LabelActions create() => LabelActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$labelActionsHash() => r'55201a7eaf0a1ba9534daefea1997ecdae09575b';

abstract class _$LabelActions extends $Notifier<AsyncValue<void>> {
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
