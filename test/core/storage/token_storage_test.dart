import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class _MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('TokenStorage', () {
    late _MockFlutterSecureStorage secureStorage;
    late TokenStorage tokenStorage;

    setUp(() {
      secureStorage = _MockFlutterSecureStorage();
      tokenStorage = TokenStorage(secureStorage);
    });

    test('reads access and refresh tokens', () async {
      when(
        () => secureStorage.read(key: 'access_token'),
      ).thenAnswer((_) async => 'access');
      when(
        () => secureStorage.read(key: 'refresh_token'),
      ).thenAnswer((_) async => 'refresh');

      expect(await tokenStorage.getAccessToken(), 'access');
      expect(await tokenStorage.getRefreshToken(), 'refresh');
    });

    test('saveTokens writes both token values', () async {
      when(
        () => secureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await tokenStorage.saveTokens(access: 'access', refresh: 'refresh');

      verify(
        () => secureStorage.write(key: 'access_token', value: 'access'),
      ).called(1);
      verify(
        () => secureStorage.write(key: 'refresh_token', value: 'refresh'),
      ).called(1);
    });

    test('clearTokens deletes both token values', () async {
      when(
        () => secureStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await tokenStorage.clearTokens();

      verify(() => secureStorage.delete(key: 'access_token')).called(1);
      verify(() => secureStorage.delete(key: 'refresh_token')).called(1);
    });

    test('read errors are treated as missing tokens and cleared', () async {
      when(
        () => secureStorage.read(key: 'access_token'),
      ).thenThrow(Exception('corrupt crypto payload'));
      when(
        () => secureStorage.delete(key: 'access_token'),
      ).thenAnswer((_) async {});

      expect(await tokenStorage.getAccessToken(), isNull);
      verify(() => secureStorage.delete(key: 'access_token')).called(1);
    });

    test('clearTokens swallows storage delete errors', () async {
      when(
        () => secureStorage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('platform failure'));

      await expectLater(tokenStorage.clearTokens(), completes);
    });
  });
}
