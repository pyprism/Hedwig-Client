// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mailboxRulesHash() => r'09427424940ab9d367eda4ddfb0af86ca129299c';

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

/// See also [mailboxRules].
@ProviderFor(mailboxRules)
const mailboxRulesProvider = MailboxRulesFamily();

/// See also [mailboxRules].
class MailboxRulesFamily extends Family<AsyncValue<List<MailboxRule>>> {
  /// See also [mailboxRules].
  const MailboxRulesFamily();

  /// See also [mailboxRules].
  MailboxRulesProvider call(String mailboxId) {
    return MailboxRulesProvider(mailboxId);
  }

  @override
  MailboxRulesProvider getProviderOverride(
    covariant MailboxRulesProvider provider,
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
  String? get name => r'mailboxRulesProvider';
}

/// See also [mailboxRules].
class MailboxRulesProvider
    extends AutoDisposeFutureProvider<List<MailboxRule>> {
  /// See also [mailboxRules].
  MailboxRulesProvider(String mailboxId)
    : this._internal(
        (ref) => mailboxRules(ref as MailboxRulesRef, mailboxId),
        from: mailboxRulesProvider,
        name: r'mailboxRulesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$mailboxRulesHash,
        dependencies: MailboxRulesFamily._dependencies,
        allTransitiveDependencies:
            MailboxRulesFamily._allTransitiveDependencies,
        mailboxId: mailboxId,
      );

  MailboxRulesProvider._internal(
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
    FutureOr<List<MailboxRule>> Function(MailboxRulesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MailboxRulesProvider._internal(
        (ref) => create(ref as MailboxRulesRef),
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
  AutoDisposeFutureProviderElement<List<MailboxRule>> createElement() {
    return _MailboxRulesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MailboxRulesProvider && other.mailboxId == mailboxId;
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
mixin MailboxRulesRef on AutoDisposeFutureProviderRef<List<MailboxRule>> {
  /// The parameter `mailboxId` of this provider.
  String get mailboxId;
}

class _MailboxRulesProviderElement
    extends AutoDisposeFutureProviderElement<List<MailboxRule>>
    with MailboxRulesRef {
  _MailboxRulesProviderElement(super.provider);

  @override
  String get mailboxId => (origin as MailboxRulesProvider).mailboxId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
