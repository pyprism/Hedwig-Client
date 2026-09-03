import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:hedwig_client/core/storage/user_cache.dart';
import 'package:hedwig_client/features/auth/data/repositories/auth_repository.dart';
import 'package:hedwig_client/features/auth/domain/entities/auth_state.dart';
import 'package:hedwig_client/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hedwig_client/shared/models/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_secure_storage.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

const _user = HedwigUser(
  id: 'u1',
  username: 'alice',
  email: 'alice@example.test',
);

const _mustChangeUser = HedwigUser(
  id: 'u1',
  username: 'alice',
  email: 'alice@example.test',
  mustChangePassword: true,
);

void main() {
  late _MockAuthRepository authRepo;
  late SharedPreferences prefs;

  ProviderContainer buildContainer() => ProviderContainer(
    overrides: [
      secureStorageProvider.overrideWithValue(fakeSecureStorage()),
      prefsStorageProvider.overrideWithValue(prefs),
      authRepositoryProvider.overrideWithValue(authRepo),
    ],
  );

  setUp(() async {
    authRepo = _MockAuthRepository();
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  group('AuthController.build', () {
    test('no stored access token yields unauthenticated', () async {
      final container = buildContainer();
      addTearDown(container.dispose);

      final state = await container.read(authControllerProvider.future);

      expect(state, const AuthState.unauthenticated());
      verifyNever(() => authRepo.getMe());
    });

    test(
      'valid token + getMe success yields authenticated and caches the user',
      () async {
        final container = buildContainer();
        addTearDown(container.dispose);
        await container
            .read(tokenStorageProvider)
            .saveTokens(access: 'acc', refresh: 'ref');
        when(() => authRepo.getMe()).thenAnswer((_) async => _user);

        final state = await container.read(authControllerProvider.future);

        expect(state, isA<Authenticated>());
        expect((state as Authenticated).user, _user);
        expect(container.read(userCacheProvider).load(), _user);
      },
    );

    test(
      'getMe reports mustChangePassword when the user requires it',
      () async {
        final container = buildContainer();
        addTearDown(container.dispose);
        await container
            .read(tokenStorageProvider)
            .saveTokens(access: 'acc', refresh: 'ref');
        when(() => authRepo.getMe()).thenAnswer((_) async => _mustChangeUser);

        final state = await container.read(authControllerProvider.future);

        expect(state, isA<MustChangePassword>());
      },
    );

    test('AuthFailure clears tokens and cache, then unauthenticated', () async {
      final container = buildContainer();
      addTearDown(container.dispose);
      final tokenStorage = container.read(tokenStorageProvider);
      await tokenStorage.saveTokens(access: 'acc', refresh: 'ref');
      await container.read(userCacheProvider).save(_user);
      when(() => authRepo.getMe())
          .thenThrow(const ApiException(Failure.auth()));

      final state = await container.read(authControllerProvider.future);

      expect(state, const AuthState.unauthenticated());
      expect(await tokenStorage.getAccessToken(), isNull);
      expect(container.read(userCacheProvider).load(), isNull);
    });

    test('non-auth error falls back to the cached user when present', () async {
      final container = buildContainer();
      addTearDown(container.dispose);
      await container
          .read(tokenStorageProvider)
          .saveTokens(access: 'acc', refresh: 'ref');
      await container.read(userCacheProvider).save(_user);
      when(() => authRepo.getMe())
          .thenThrow(const ApiException(Failure.network(message: 'offline')));

      final state = await container.read(authControllerProvider.future);

      expect(state, isA<Authenticated>());
      expect((state as Authenticated).user, _user);
    });

    test(
      'non-auth error with no cached user falls back to unauthenticated',
      () async {
        final container = buildContainer();
        addTearDown(container.dispose);
        await container
            .read(tokenStorageProvider)
            .saveTokens(access: 'acc', refresh: 'ref');
        when(() => authRepo.getMe())
            .thenThrow(const ApiException(Failure.network(message: 'offline')));

        final state = await container.read(authControllerProvider.future);

        expect(state, const AuthState.unauthenticated());
      },
    );
  });

  group('AuthController actions', () {
    test('login stores authenticated state and caches the user', () async {
      final container = buildContainer();
      addTearDown(container.dispose);
      // No token yet: build() settles on unauthenticated first.
      await container.read(authControllerProvider.future);
      when(
        () => authRepo.login(
          baseUrl: any(named: 'baseUrl'),
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => _user);

      await container
          .read(authControllerProvider.notifier)
          .login(
            baseUrl: 'https://api.example.test',
            username: 'alice',
            password: 'secret',
          );

      final state = container.read(authControllerProvider).value;
      expect(state, isA<Authenticated>());
      expect(container.read(userCacheProvider).load(), _user);
    });

    test('login surfaces a failed AsyncValue on error', () async {
      final container = buildContainer();
      addTearDown(container.dispose);
      await container.read(authControllerProvider.future);
      when(
        () => authRepo.login(
          baseUrl: any(named: 'baseUrl'),
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const ApiException(Failure.auth(message: 'bad creds')));

      await container
          .read(authControllerProvider.notifier)
          .login(
            baseUrl: 'https://api.example.test',
            username: 'a',
            password: 'b',
          );

      expect(container.read(authControllerProvider).hasError, isTrue);
    });

    test(
      'logout clears state, cache, and delegates to the repository',
      () async {
        final container = buildContainer();
        addTearDown(container.dispose);
        await container
            .read(tokenStorageProvider)
            .saveTokens(access: 'acc', refresh: 'ref');
        await container.read(userCacheProvider).save(_user);
        when(() => authRepo.getMe()).thenAnswer((_) async => _user);
        await container.read(authControllerProvider.future);
        when(() => authRepo.logout()).thenAnswer((_) async {});

        await container.read(authControllerProvider.notifier).logout();

        verify(() => authRepo.logout()).called(1);
        expect(
          container.read(authControllerProvider).value,
          const AuthState.unauthenticated(),
        );
        expect(container.read(userCacheProvider).load(), isNull);
      },
    );

    test('updateProfile is a no-op when not authenticated', () async {
      final container = buildContainer();
      addTearDown(container.dispose);
      await container.read(authControllerProvider.future);

      await container
          .read(authControllerProvider.notifier)
          .updateProfile(displayName: 'New Name');

      verifyNever(
        () => authRepo.patchMe(
          displayName: any(named: 'displayName'),
          firstName: any(named: 'firstName'),
          lastName: any(named: 'lastName'),
          timezone: any(named: 'timezone'),
          locale: any(named: 'locale'),
        ),
      );
    });

    test('updateProfile replaces the authenticated user on success', () async {
      final container = buildContainer();
      addTearDown(container.dispose);
      await container
          .read(tokenStorageProvider)
          .saveTokens(access: 'acc', refresh: 'ref');
      when(() => authRepo.getMe()).thenAnswer((_) async => _user);
      await container.read(authControllerProvider.future);
      const updated = HedwigUser(
        id: 'u1',
        username: 'alice',
        email: 'alice@example.test',
        displayName: 'New Name',
      );
      when(
        () => authRepo.patchMe(
          displayName: any(named: 'displayName'),
          firstName: any(named: 'firstName'),
          lastName: any(named: 'lastName'),
          timezone: any(named: 'timezone'),
          locale: any(named: 'locale'),
        ),
      ).thenAnswer((_) async => updated);

      await container
          .read(authControllerProvider.notifier)
          .updateProfile(displayName: 'New Name');

      final state = container.read(authControllerProvider).value;
      expect((state as Authenticated).user.displayName, 'New Name');
    });
  });
}
