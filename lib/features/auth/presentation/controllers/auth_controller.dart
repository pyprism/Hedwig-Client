import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:hedwig_client/core/storage/user_cache.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/features/auth/data/repositories/auth_repository.dart';
import 'package:hedwig_client/features/auth/domain/entities/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    final storage = ref.watch(tokenStorageProvider);
    final accessToken = await storage.getAccessToken();
    if (accessToken == null) return const AuthState.unauthenticated();

    final cache = ref.read(userCacheProvider);
    try {
      final user = await ref.read(authRepositoryProvider).getMe();
      await cache.save(user);
      if (user.mustChangePassword) {
        return AuthState.mustChangePassword(user: user);
      }
      return AuthState.authenticated(user: user);
    } catch (e) {
      if (_isAuthFailure(e)) {
        await storage.clearTokens();
        await cache.clear();
        return const AuthState.unauthenticated();
      }
      // Offline: serve cached user so inbox opens without network.
      final cached = cache.load();
      if (cached != null) {
        return cached.mustChangePassword
            ? AuthState.mustChangePassword(user: cached)
            : AuthState.authenticated(user: cached);
      }
      return const AuthState.unauthenticated();
    }
  }

  bool _isAuthFailure(Object error) {
    if (error is ApiException) {
      return error.failure is AuthFailure;
    }
    return false;
  }

  Future<void> login({
    required String baseUrl,
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .login(baseUrl: baseUrl, username: username, password: password);
      // Seed the cache so an offline restart (token present, getMe unreachable)
      // can still recognize this user instead of falling back to unauthenticated.
      await ref.read(userCacheProvider).save(user);
      if (user.mustChangePassword) {
        return AuthState.mustChangePassword(user: user);
      }
      return AuthState.authenticated(user: user);
    });
  }

  Future<void> register({
    required String baseUrl,
    required String username,
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .register(
            baseUrl: baseUrl,
            username: username,
            email: email,
            password: password,
            displayName: displayName,
          );
      await ref.read(userCacheProvider).save(user);
      if (user.mustChangePassword) {
        return AuthState.mustChangePassword(user: user);
      }
      return AuthState.authenticated(user: user);
    });
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          );
      return AuthState.authenticated(user: user);
    });
  }

  Future<void> updateProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? timezone,
    String? locale,
  }) async {
    final current = state.valueOrNull;
    final currentUser = switch (current) {
      Authenticated(:final user) => user,
      MustChangePassword(:final user) => user,
      _ => null,
    };
    if (currentUser == null) return;

    final updated = await ref
        .read(authRepositoryProvider)
        .patchMe(
          displayName: displayName,
          firstName: firstName,
          lastName: lastName,
          timezone: timezone,
          locale: locale,
        );
    state = AsyncValue.data(
      updated.mustChangePassword
          ? AuthState.mustChangePassword(user: updated)
          : AuthState.authenticated(user: updated),
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    await ref.read(userCacheProvider).clear();
    state = const AsyncValue.data(AuthState.unauthenticated());
  }
}
