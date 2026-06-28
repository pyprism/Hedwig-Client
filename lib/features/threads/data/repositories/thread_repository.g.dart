// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadRepositoryHash() => r'142436c92221e6cf7e81bbdaf06ef8d0b1d06dfe';

/// See also [threadRepository].
@ProviderFor(threadRepository)
final threadRepositoryProvider = Provider<ThreadRepository>.internal(
  threadRepository,
  name: r'threadRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$threadRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThreadRepositoryRef = ProviderRef<ThreadRepository>;
String _$threadCountsHash() => r'b28533510caeaec0ddc3a211b819492a21116b82';

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

/// See also [threadCounts].
@ProviderFor(threadCounts)
const threadCountsProvider = ThreadCountsFamily();

/// See also [threadCounts].
class ThreadCountsFamily extends Family<AsyncValue<ThreadCounts>> {
  /// See also [threadCounts].
  const ThreadCountsFamily();

  /// See also [threadCounts].
  ThreadCountsProvider call(String mailboxId) {
    return ThreadCountsProvider(mailboxId);
  }

  @override
  ThreadCountsProvider getProviderOverride(
    covariant ThreadCountsProvider provider,
  ) {
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
  String? get name => r'threadCountsProvider';
}

/// See also [threadCounts].
class ThreadCountsProvider extends AutoDisposeFutureProvider<ThreadCounts> {
  /// See also [threadCounts].
  ThreadCountsProvider(String mailboxId)
    : this._internal(
        (ref) => threadCounts(ref as ThreadCountsRef, mailboxId),
        from: threadCountsProvider,
        name: r'threadCountsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$threadCountsHash,
        dependencies: ThreadCountsFamily._dependencies,
        allTransitiveDependencies:
            ThreadCountsFamily._allTransitiveDependencies,
        mailboxId: mailboxId,
      );

  ThreadCountsProvider._internal(
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
    FutureOr<ThreadCounts> Function(ThreadCountsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThreadCountsProvider._internal(
        (ref) => create(ref as ThreadCountsRef),
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
  AutoDisposeFutureProviderElement<ThreadCounts> createElement() {
    return _ThreadCountsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadCountsProvider && other.mailboxId == mailboxId;
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
mixin ThreadCountsRef on AutoDisposeFutureProviderRef<ThreadCounts> {
  /// The parameter `mailboxId` of this provider.
  String get mailboxId;
}

class _ThreadCountsProviderElement
    extends AutoDisposeFutureProviderElement<ThreadCounts>
    with ThreadCountsRef {
  _ThreadCountsProviderElement(super.provider);

  @override
  String get mailboxId => (origin as ThreadCountsProvider).mailboxId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
