// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadListHash() => r'61c02de0127a945e35064c49deef9b24efba4c09';

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

/// See also [threadList].
@ProviderFor(threadList)
const threadListProvider = ThreadListFamily();

/// See also [threadList].
class ThreadListFamily extends Family<AsyncValue<List<MailThread>>> {
  /// See also [threadList].
  const ThreadListFamily();

  /// See also [threadList].
  ThreadListProvider call({
    required String mailboxId,
    String folder = 'inbox',
    String? search,
  }) {
    return ThreadListProvider(
      mailboxId: mailboxId,
      folder: folder,
      search: search,
    );
  }

  @override
  ThreadListProvider getProviderOverride(
    covariant ThreadListProvider provider,
  ) {
    return call(
      mailboxId: provider.mailboxId,
      folder: provider.folder,
      search: provider.search,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'threadListProvider';
}

/// See also [threadList].
class ThreadListProvider extends AutoDisposeStreamProvider<List<MailThread>> {
  /// See also [threadList].
  ThreadListProvider({
    required String mailboxId,
    String folder = 'inbox',
    String? search,
  }) : this._internal(
         (ref) => threadList(
           ref as ThreadListRef,
           mailboxId: mailboxId,
           folder: folder,
           search: search,
         ),
         from: threadListProvider,
         name: r'threadListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$threadListHash,
         dependencies: ThreadListFamily._dependencies,
         allTransitiveDependencies: ThreadListFamily._allTransitiveDependencies,
         mailboxId: mailboxId,
         folder: folder,
         search: search,
       );

  ThreadListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mailboxId,
    required this.folder,
    required this.search,
  }) : super.internal();

  final String mailboxId;
  final String folder;
  final String? search;

  @override
  Override overrideWith(
    Stream<List<MailThread>> Function(ThreadListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThreadListProvider._internal(
        (ref) => create(ref as ThreadListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mailboxId: mailboxId,
        folder: folder,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MailThread>> createElement() {
    return _ThreadListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadListProvider &&
        other.mailboxId == mailboxId &&
        other.folder == folder &&
        other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mailboxId.hashCode);
    hash = _SystemHash.combine(hash, folder.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ThreadListRef on AutoDisposeStreamProviderRef<List<MailThread>> {
  /// The parameter `mailboxId` of this provider.
  String get mailboxId;

  /// The parameter `folder` of this provider.
  String get folder;

  /// The parameter `search` of this provider.
  String? get search;
}

class _ThreadListProviderElement
    extends AutoDisposeStreamProviderElement<List<MailThread>>
    with ThreadListRef {
  _ThreadListProviderElement(super.provider);

  @override
  String get mailboxId => (origin as ThreadListProvider).mailboxId;
  @override
  String get folder => (origin as ThreadListProvider).folder;
  @override
  String? get search => (origin as ThreadListProvider).search;
}

String _$selectedThreadHash() => r'69d8988ea0173942c7e11a218ff39e40d60efa36';

/// Selected thread for two-pane layout on expanded screens.
///
/// Copied from [SelectedThread].
@ProviderFor(SelectedThread)
final selectedThreadProvider =
    NotifierProvider<SelectedThread, String?>.internal(
      SelectedThread.new,
      name: r'selectedThreadProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedThreadHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedThread = Notifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
