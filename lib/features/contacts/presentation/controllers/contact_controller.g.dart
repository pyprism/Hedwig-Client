// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactListHash() => r'0b70860f831bc4fae999aa663db3a57e79e758dc';

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

/// See also [contactList].
@ProviderFor(contactList)
const contactListProvider = ContactListFamily();

/// See also [contactList].
class ContactListFamily extends Family<AsyncValue<List<Contact>>> {
  /// See also [contactList].
  const ContactListFamily();

  /// See also [contactList].
  ContactListProvider call(String mailboxId) {
    return ContactListProvider(mailboxId);
  }

  @override
  ContactListProvider getProviderOverride(
    covariant ContactListProvider provider,
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
  String? get name => r'contactListProvider';
}

/// See also [contactList].
class ContactListProvider extends AutoDisposeStreamProvider<List<Contact>> {
  /// See also [contactList].
  ContactListProvider(String mailboxId)
    : this._internal(
        (ref) => contactList(ref as ContactListRef, mailboxId),
        from: contactListProvider,
        name: r'contactListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$contactListHash,
        dependencies: ContactListFamily._dependencies,
        allTransitiveDependencies: ContactListFamily._allTransitiveDependencies,
        mailboxId: mailboxId,
      );

  ContactListProvider._internal(
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
    Stream<List<Contact>> Function(ContactListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ContactListProvider._internal(
        (ref) => create(ref as ContactListRef),
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
  AutoDisposeStreamProviderElement<List<Contact>> createElement() {
    return _ContactListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContactListProvider && other.mailboxId == mailboxId;
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
mixin ContactListRef on AutoDisposeStreamProviderRef<List<Contact>> {
  /// The parameter `mailboxId` of this provider.
  String get mailboxId;
}

class _ContactListProviderElement
    extends AutoDisposeStreamProviderElement<List<Contact>>
    with ContactListRef {
  _ContactListProviderElement(super.provider);

  @override
  String get mailboxId => (origin as ContactListProvider).mailboxId;
}

String _$contactActionsHash() => r'922a482be7f2d63322bd73587f387d871d97ce21';

/// See also [ContactActions].
@ProviderFor(ContactActions)
final contactActionsProvider =
    AutoDisposeNotifierProvider<ContactActions, AsyncValue<void>>.internal(
      ContactActions.new,
      name: r'contactActionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contactActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ContactActions = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
