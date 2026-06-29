// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mailboxList)
final mailboxListProvider = MailboxListProvider._();

final class MailboxListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Mailbox>>,
          List<Mailbox>,
          Stream<List<Mailbox>>
        >
    with $FutureModifier<List<Mailbox>>, $StreamProvider<List<Mailbox>> {
  MailboxListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mailboxListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mailboxListHash();

  @$internal
  @override
  $StreamProviderElement<List<Mailbox>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Mailbox>> create(Ref ref) {
    return mailboxList(ref);
  }
}

String _$mailboxListHash() => r'22f2dd0956a90b8e0f38110350692300d9fb731f';

/// The currently selected mailbox id.

@ProviderFor(SelectedMailbox)
final selectedMailboxProvider = SelectedMailboxProvider._();

/// The currently selected mailbox id.
final class SelectedMailboxProvider
    extends $NotifierProvider<SelectedMailbox, String?> {
  /// The currently selected mailbox id.
  SelectedMailboxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedMailboxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedMailboxHash();

  @$internal
  @override
  SelectedMailbox create() => SelectedMailbox();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedMailboxHash() => r'4810073411fec6905a806c1dc45899eeb5bb2e23';

/// The currently selected mailbox id.

abstract class _$SelectedMailbox extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The currently selected folder name.

@ProviderFor(SelectedFolder)
final selectedFolderProvider = SelectedFolderProvider._();

/// The currently selected folder name.
final class SelectedFolderProvider
    extends $NotifierProvider<SelectedFolder, String> {
  /// The currently selected folder name.
  SelectedFolderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFolderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFolderHash();

  @$internal
  @override
  SelectedFolder create() => SelectedFolder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$selectedFolderHash() => r'ee7536713c6d81e69081a2ac2e590b2bd4e97237';

/// The currently selected folder name.

abstract class _$SelectedFolder extends $Notifier<String> {
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
