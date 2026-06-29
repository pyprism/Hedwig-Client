// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contactList)
final contactListProvider = ContactListFamily._();

final class ContactListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Contact>>,
          List<Contact>,
          Stream<List<Contact>>
        >
    with $FutureModifier<List<Contact>>, $StreamProvider<List<Contact>> {
  ContactListProvider._({
    required ContactListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'contactListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contactListHash();

  @override
  String toString() {
    return r'contactListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Contact>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Contact>> create(Ref ref) {
    final argument = this.argument as String;
    return contactList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContactListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contactListHash() => r'0b70860f831bc4fae999aa663db3a57e79e758dc';

final class ContactListFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Contact>>, String> {
  ContactListFamily._()
    : super(
        retry: null,
        name: r'contactListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContactListProvider call(String mailboxId) =>
      ContactListProvider._(argument: mailboxId, from: this);

  @override
  String toString() => r'contactListProvider';
}

@ProviderFor(ContactActions)
final contactActionsProvider = ContactActionsProvider._();

final class ContactActionsProvider
    extends $NotifierProvider<ContactActions, AsyncValue<void>> {
  ContactActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactActionsHash();

  @$internal
  @override
  ContactActions create() => ContactActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$contactActionsHash() => r'922a482be7f2d63322bd73587f387d871d97ce21';

abstract class _$ContactActions extends $Notifier<AsyncValue<void>> {
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
