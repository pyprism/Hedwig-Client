// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_unassigned_mail_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminUnassignedMail)
final adminUnassignedMailProvider = AdminUnassignedMailProvider._();

final class AdminUnassignedMailProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UnassignedAddress>>,
          List<UnassignedAddress>,
          FutureOr<List<UnassignedAddress>>
        >
    with
        $FutureModifier<List<UnassignedAddress>>,
        $FutureProvider<List<UnassignedAddress>> {
  AdminUnassignedMailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminUnassignedMailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminUnassignedMailHash();

  @$internal
  @override
  $FutureProviderElement<List<UnassignedAddress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UnassignedAddress>> create(Ref ref) {
    return adminUnassignedMail(ref);
  }
}

String _$adminUnassignedMailHash() =>
    r'6e97fb6bf2ea14ffd0ac16403c353c6d174355b0';
