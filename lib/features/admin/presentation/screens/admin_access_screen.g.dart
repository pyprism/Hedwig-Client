// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_access_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminAccessGrants)
final adminAccessGrantsProvider = AdminAccessGrantsProvider._();

final class AdminAccessGrantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AccessGrant>>,
          List<AccessGrant>,
          FutureOr<List<AccessGrant>>
        >
    with
        $FutureModifier<List<AccessGrant>>,
        $FutureProvider<List<AccessGrant>> {
  AdminAccessGrantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAccessGrantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAccessGrantsHash();

  @$internal
  @override
  $FutureProviderElement<List<AccessGrant>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AccessGrant>> create(Ref ref) {
    return adminAccessGrants(ref);
  }
}

String _$adminAccessGrantsHash() => r'400e5d52102be1283224b1d2d28c3e92e8b81f36';
