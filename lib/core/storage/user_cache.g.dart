// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userCache)
final userCacheProvider = UserCacheProvider._();

final class UserCacheProvider
    extends $FunctionalProvider<UserCache, UserCache, UserCache>
    with $Provider<UserCache> {
  UserCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCacheHash();

  @$internal
  @override
  $ProviderElement<UserCache> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserCache create(Ref ref) {
    return userCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserCache value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserCache>(value),
    );
  }
}

String _$userCacheHash() => r'1dbc5f083090deac062600daa2f7c32ce6b5799b';
