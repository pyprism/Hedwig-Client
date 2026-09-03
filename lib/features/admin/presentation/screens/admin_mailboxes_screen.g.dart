// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_mailboxes_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminMailboxes)
final adminMailboxesProvider = AdminMailboxesProvider._();

final class AdminMailboxesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdminMailbox>>,
          List<AdminMailbox>,
          FutureOr<List<AdminMailbox>>
        >
    with
        $FutureModifier<List<AdminMailbox>>,
        $FutureProvider<List<AdminMailbox>> {
  AdminMailboxesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminMailboxesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminMailboxesHash();

  @$internal
  @override
  $FutureProviderElement<List<AdminMailbox>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdminMailbox>> create(Ref ref) {
    return adminMailboxes(ref);
  }
}

String _$adminMailboxesHash() => r'2e8cd83a806ae4c63225d4b0da3c6166edba3055';
