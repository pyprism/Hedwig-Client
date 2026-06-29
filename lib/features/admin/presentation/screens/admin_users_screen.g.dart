// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_users_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminUsers)
final adminUsersProvider = AdminUsersProvider._();

final class AdminUsersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdminUser>>,
          List<AdminUser>,
          FutureOr<List<AdminUser>>
        >
    with $FutureModifier<List<AdminUser>>, $FutureProvider<List<AdminUser>> {
  AdminUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminUsersHash();

  @$internal
  @override
  $FutureProviderElement<List<AdminUser>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdminUser>> create(Ref ref) {
    return adminUsers(ref);
  }
}

String _$adminUsersHash() => r'176f706001bf70cc4da7adc413070e3773fe04b4';
