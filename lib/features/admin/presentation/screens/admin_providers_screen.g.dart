// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_providers_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminProviders)
final adminProvidersProvider = AdminProvidersProvider._();

final class AdminProvidersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EmailProvider>>,
          List<EmailProvider>,
          FutureOr<List<EmailProvider>>
        >
    with
        $FutureModifier<List<EmailProvider>>,
        $FutureProvider<List<EmailProvider>> {
  AdminProvidersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminProvidersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminProvidersHash();

  @$internal
  @override
  $FutureProviderElement<List<EmailProvider>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EmailProvider>> create(Ref ref) {
    return adminProviders(ref);
  }
}

String _$adminProvidersHash() => r'cfc59451c46e255453c863ecb82f1d93ffc3135c';
