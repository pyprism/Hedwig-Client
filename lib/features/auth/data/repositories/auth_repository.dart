import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/config/app_config.dart';
import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:hedwig_client/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hedwig_client/shared/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    ref: ref,
    tokenStorage: ref.watch(tokenStorageProvider),
  );
}

class AuthRepository {
  const AuthRepository({required this.ref, required this.tokenStorage});

  final Ref ref;
  final TokenStorage tokenStorage;

  // Read fresh each call: appConfigProvider is autoDispose, so caching the
  // notifier at provider-build time risks holding a stale, disposed instance
  // that dioClient (watching the live provider) no longer sees updates from.
  AppConfig get appConfig => ref.read(appConfigProvider.notifier);

  AuthRemoteDatasource get remote =>
      AuthRemoteDatasource(ref.read(dioClientProvider));

  Future<HedwigUser> login({
    required String baseUrl,
    required String username,
    required String password,
  }) async {
    await appConfig.setBaseUrl(baseUrl);
    ref.invalidate(dioClientProvider);
    final tokens = await remote.login(username, password);
    await tokenStorage.saveTokens(
      access: tokens.access,
      refresh: tokens.refresh,
    );
    return remote.getMe();
  }

  Future<HedwigUser> register({
    required String baseUrl,
    required String username,
    required String email,
    required String password,
    String? displayName,
  }) async {
    await appConfig.setBaseUrl(baseUrl);
    ref.invalidate(dioClientProvider);
    final user = await remote.register(
      username: username,
      email: email,
      password: password,
      displayName: displayName,
    );
    // After register, login to get tokens.
    final tokens = await remote.login(username, password);
    await tokenStorage.saveTokens(
      access: tokens.access,
      refresh: tokens.refresh,
    );
    return user;
  }

  Future<HedwigUser> getMe() => remote.getMe();

  Future<HedwigUser> patchMe({
    String? displayName,
    String? firstName,
    String? lastName,
    String? timezone,
    String? locale,
  }) => remote.patchMe(
    displayName: displayName,
    firstName: firstName,
    lastName: lastName,
    timezone: timezone,
    locale: locale,
  );

  Future<HedwigUser> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => remote.changePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );

  Future<void> logout() async {
    final refresh = await tokenStorage.getRefreshToken();
    if (refresh != null) {
      try {
        await remote.logout(refresh);
      } catch (_) {}
    }
    await tokenStorage.clearTokens();
    await appConfig.clear();
  }
}
