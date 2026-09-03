import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

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
  late AuthRemoteDatasource datasource;

  setUp(() {
    dio = _MockDio();
    datasource = AuthRemoteDatasource(dio);
  });

  group('AuthRemoteDatasource', () {
    test(
      'login posts credentials to token/ and parses the token pair',
      () async {
        when(() => dio.post('token/', data: any(named: 'data')))
            .thenAnswer((_) async => _res({'access': 'acc', 'refresh': 'ref'}));

        final tokens = await datasource.login('alice', 'secret');

        verify(
          () => dio.post(
            'token/',
            data: {'username': 'alice', 'password': 'secret'},
          ),
        ).called(1);
        expect(tokens.access, 'acc');
        expect(tokens.refresh, 'ref');
      },
    );

    test('register omits null optional fields from the payload', () async {
      when(() => dio.post('accounts/users/register/', data: any(named: 'data')))
          .thenAnswer(
            (_) async => _res({
              'id': 'u1',
              'username': 'alice',
              'email': 'alice@example.test',
            }),
          );

      await datasource.register(
        username: 'alice',
        email: 'alice@example.test',
        password: 'secret',
      );

      final captured =
          verify(
                () => dio.post(
                  'accounts/users/register/',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured, {
        'username': 'alice',
        'email': 'alice@example.test',
        'password': 'secret',
      });
    });

    test('register includes optional fields when provided', () async {
      when(() => dio.post('accounts/users/register/', data: any(named: 'data')))
          .thenAnswer(
            (_) async => _res({
              'id': 'u1',
              'username': 'alice',
              'email': 'alice@example.test',
            }),
          );

      await datasource.register(
        username: 'alice',
        email: 'alice@example.test',
        password: 'secret',
        displayName: 'Alice',
        timezone: 'UTC',
        locale: 'en',
      );

      final captured =
          verify(
                () => dio.post(
                  'accounts/users/register/',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured['display_name'], 'Alice');
      expect(captured['timezone'], 'UTC');
      expect(captured['locale'], 'en');
    });

    test('getMe fetches accounts/users/me/', () async {
      when(() => dio.get('accounts/users/me/')).thenAnswer(
        (_) async => _res({
          'id': 'u1',
          'username': 'alice',
          'email': 'alice@example.test',
        }),
      );

      final user = await datasource.getMe();

      expect(user.id, 'u1');
      expect(user.username, 'alice');
    });

    test('changePassword posts current and new password', () async {
      when(
        () => dio.post(
          'accounts/users/change-password/',
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => _res({
          'id': 'u1',
          'username': 'alice',
          'email': 'alice@example.test',
        }),
      );

      await datasource.changePassword(
        currentPassword: 'old',
        newPassword: 'new',
      );

      verify(
        () => dio.post(
          'accounts/users/change-password/',
          data: {'current_password': 'old', 'new_password': 'new'},
        ),
      ).called(1);
    });

    test('patchMe only sends the fields that were provided', () async {
      when(() => dio.patch('accounts/users/me/', data: any(named: 'data')))
          .thenAnswer(
            (_) async => _res({
              'id': 'u1',
              'username': 'alice',
              'email': 'alice@example.test',
            }),
          );

      await datasource.patchMe(displayName: 'Alice B');

      final captured =
          verify(
                () => dio.patch(
                  'accounts/users/me/',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured, {'display_name': 'Alice B'});
    });

    test('logout blacklists the refresh token', () async {
      when(() => dio.post('token/blacklist/', data: any(named: 'data')))
          .thenAnswer((_) async => _res(null));

      await datasource.logout('ref-token');

      verify(() => dio.post('token/blacklist/', data: {'refresh': 'ref-token'}))
          .called(1);
    });
  });
}
