// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadMessagesHash() => r'aa5276ccc68de2a209a68b6fe77409fadb560dbc';

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

/// See also [threadMessages].
@ProviderFor(threadMessages)
const threadMessagesProvider = ThreadMessagesFamily();

/// See also [threadMessages].
class ThreadMessagesFamily extends Family<AsyncValue<List<MailMessage>>> {
  /// See also [threadMessages].
  const ThreadMessagesFamily();

  /// See also [threadMessages].
  ThreadMessagesProvider call(String threadId) {
    return ThreadMessagesProvider(threadId);
  }

  @override
  ThreadMessagesProvider getProviderOverride(
    covariant ThreadMessagesProvider provider,
  ) {
    return call(provider.threadId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'threadMessagesProvider';
}

/// See also [threadMessages].
class ThreadMessagesProvider
    extends AutoDisposeStreamProvider<List<MailMessage>> {
  /// See also [threadMessages].
  ThreadMessagesProvider(String threadId)
    : this._internal(
        (ref) => threadMessages(ref as ThreadMessagesRef, threadId),
        from: threadMessagesProvider,
        name: r'threadMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$threadMessagesHash,
        dependencies: ThreadMessagesFamily._dependencies,
        allTransitiveDependencies:
            ThreadMessagesFamily._allTransitiveDependencies,
        threadId: threadId,
      );

  ThreadMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.threadId,
  }) : super.internal();

  final String threadId;

  @override
  Override overrideWith(
    Stream<List<MailMessage>> Function(ThreadMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThreadMessagesProvider._internal(
        (ref) => create(ref as ThreadMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        threadId: threadId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MailMessage>> createElement() {
    return _ThreadMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadMessagesProvider && other.threadId == threadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ThreadMessagesRef on AutoDisposeStreamProviderRef<List<MailMessage>> {
  /// The parameter `threadId` of this provider.
  String get threadId;
}

class _ThreadMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<MailMessage>>
    with ThreadMessagesRef {
  _ThreadMessagesProviderElement(super.provider);

  @override
  String get threadId => (origin as ThreadMessagesProvider).threadId;
}

String _$messageStateControllerHash() =>
    r'b8e5354564e7465609ff57c9a8d9451805f9d9b1';

/// See also [MessageStateController].
@ProviderFor(MessageStateController)
final messageStateControllerProvider =
    AutoDisposeNotifierProvider<
      MessageStateController,
      AsyncValue<void>
    >.internal(
      MessageStateController.new,
      name: r'messageStateControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$messageStateControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MessageStateController = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
