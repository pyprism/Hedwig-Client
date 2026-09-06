import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/config/app_config.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:hedwig_client/features/auth/data/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_secure_storage.dart';

class _MockDio extends Mock implements Dio {}

Response<dynamic> _res(dynamic data) => Response(
  requestOptions: RequestOptions(path: ''),
  data: data,
);

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  late _MockDio dio;
  late ProviderContainer container;

  setUp(() async {
    dio = _MockDio();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [
        dioClientProvider.overrideWithValue(dio),
        prefsStorageProvider.overrideWithValue(prefs),
        secureStorageProvider.overrideWithValue(fakeSecureStorage()),
      ],
    );
  });

  tearDown(() => container.dispose());

  AuthRepository repo() => container.read(authRepositoryProvider);

  group('AuthRepository', () {
    test(
      'login persists the base URL, saves tokens, then fetches the user',
      () async {
        when(() => dio.post('token/', data: any(named: 'data')))
            .thenAnswer((_) async => _res({'access': 'acc', 'refresh': 'ref'}));
        when(() => dio.get('accounts/users/me/')).thenAnswer(
          (_) async => _res({
            'id': 'u1',
            'username': 'alice',
            'email': 'alice@example.test',
          }),
        );

        final user = await repo().login(
          baseUrl: 'https://api.example.test',
          username: 'alice',
          password: 'secret',
        );

        expect(user.username, 'alice');
        expect(container.read(appConfigProvider), 'https://api.example.test');
        final tokenStorage = container.read(tokenStorageProvider);
        expect(await tokenStorage.getAccessToken(), 'acc');
        expect(await tokenStorage.getRefreshToken(), 'ref');
      },
    );

    test(
      'register creates the account, then logs in to obtain tokens',
      () async {
        when(
          () => dio.post('accounts/users/register/', data: any(named: 'data')),
        ).thenAnswer(
          (_) async => _res({
            'id': 'u1',
            'username': 'alice',
            'email': 'alice@example.test',
          }),
        );
        when(() => dio.post('token/', data: any(named: 'data')))
            .thenAnswer((_) async => _res({'access': 'acc', 'refresh': 'ref'}));

        final user = await repo().register(
          baseUrl: 'https://api.example.test',
          username: 'alice',
          email: 'alice@example.test',
          password: 'secret',
        );

        expect(user.id, 'u1');
        final tokenStorage = container.read(tokenStorageProvider);
        expect(await tokenStorage.getAccessToken(), 'acc');
      },
    );

    test('failed login still remembers the normalized server URL', () async {
      when(
        () => dio.post('token/', data: any(named: 'data')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: 'token/')));

      await expectLater(
        repo().login(
          baseUrl: 'https://api.example.test/// ',
          username: 'alice',
          password: 'wrong',
        ),
        throwsA(isA<DioException>()),
      );

      expect(container.read(appConfigProvider), 'https://api.example.test');
    });

    test('successful logout retains the server URL', () async {
      final tokenStorage = container.read(tokenStorageProvider);
      await tokenStorage.saveTokens(access: 'acc', refresh: 'ref');
      await container
          .read(appConfigProvider.notifier)
          .setBaseUrl('https://api.example.test');
      when(() => dio.post('token/blacklist/', data: any(named: 'data')))
          .thenAnswer((_) async => _res(null));

      await repo().logout();

      expect(await tokenStorage.getAccessToken(), isNull);
      expect(await tokenStorage.getRefreshToken(), isNull);
      expect(container.read(appConfigProvider), 'https://api.example.test');
    });

    test(
      'logout clears tokens but retains the server URL when remote call fails',
      () async {
        final tokenStorage = container.read(tokenStorageProvider);
        await tokenStorage.saveTokens(access: 'acc', refresh: 'ref');
        await container
            .read(appConfigProvider.notifier)
            .setBaseUrl('https://api.example.test');
        when(() => dio.post('token/blacklist/', data: any(named: 'data')))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        await repo().logout();

        expect(await tokenStorage.getAccessToken(), isNull);
        expect(await tokenStorage.getRefreshToken(), isNull);
        expect(container.read(appConfigProvider), 'https://api.example.test');
      },
    );

    test(
      'logout skips the remote call when there is no refresh token',
      () async {
        await repo().logout();

        verifyNever(
          () => dio.post('token/blacklist/', data: any(named: 'data')),
        );
      },
    );
  });
}
