// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_domains_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminDomains)
final adminDomainsProvider = AdminDomainsProvider._();

final class AdminDomainsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdminDomain>>,
          List<AdminDomain>,
          FutureOr<List<AdminDomain>>
        >
    with
        $FutureModifier<List<AdminDomain>>,
        $FutureProvider<List<AdminDomain>> {
  AdminDomainsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminDomainsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminDomainsHash();

  @$internal
  @override
  $FutureProviderElement<List<AdminDomain>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdminDomain>> create(Ref ref) {
    return adminDomains(ref);
  }
}

String _$adminDomainsHash() => r'308ced6efe5f37f5a7b0a79ae5a9cb151a7df708';
