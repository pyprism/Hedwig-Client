// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$labelListHash() => r'3c62daf8f9c342e95319e91c3853f09764b6c67a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [labelList].
@ProviderFor(labelList)
const labelListProvider = LabelListFamily();

/// See also [labelList].
class LabelListFamily extends Family<AsyncValue<List<Label>>> {
  /// See also [labelList].
  const LabelListFamily();

  /// See also [labelList].
  LabelListProvider call(String mailboxId) {
    return LabelListProvider(mailboxId);
  }

  @override
  LabelListProvider getProviderOverride(covariant LabelListProvider provider) {
    return call(provider.mailboxId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'labelListProvider';
}

/// See also [labelList].
class LabelListProvider extends AutoDisposeStreamProvider<List<Label>> {
  /// See also [labelList].
  LabelListProvider(String mailboxId)
    : this._internal(
        (ref) => labelList(ref as LabelListRef, mailboxId),
        from: labelListProvider,
        name: r'labelListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$labelListHash,
        dependencies: LabelListFamily._dependencies,
        allTransitiveDependencies: LabelListFamily._allTransitiveDependencies,
        mailboxId: mailboxId,
      );

  LabelListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mailboxId,
  }) : super.internal();

  final String mailboxId;

  @override
  Override overrideWith(
    Stream<List<Label>> Function(LabelListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LabelListProvider._internal(
        (ref) => create(ref as LabelListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mailboxId: mailboxId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Label>> createElement() {
    return _LabelListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LabelListProvider && other.mailboxId == mailboxId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mailboxId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LabelListRef on AutoDisposeStreamProviderRef<List<Label>> {
  /// The parameter `mailboxId` of this provider.
  String get mailboxId;
}

class _LabelListProviderElement
    extends AutoDisposeStreamProviderElement<List<Label>>
    with LabelListRef {
  _LabelListProviderElement(super.provider);

  @override
  String get mailboxId => (origin as LabelListProvider).mailboxId;
}

String _$labelActionsHash() => r'55201a7eaf0a1ba9534daefea1997ecdae09575b';

/// See also [LabelActions].
@ProviderFor(LabelActions)
final labelActionsProvider =
    AutoDisposeNotifierProvider<LabelActions, AsyncValue<void>>.internal(
      LabelActions.new,
      name: r'labelActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$labelActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LabelActions = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
