import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/auth_interceptor.dart';

void main() {
  group('refresh failure logout policy', () {
    test('logs out when no refresh token is stored', () {
      expect(
        shouldLogoutAfterRefreshFailure(const MissingRefreshTokenException()),
        isTrue,
      );
    });

    for (final status in [400, 401]) {
      test('logs out when refresh is rejected with HTTP $status', () {
        final request = RequestOptions(path: 'token/refresh/');
        final error = DioException(
          requestOptions: request,
          response: Response<void>(requestOptions: request, statusCode: status),
        );

        expect(shouldLogoutAfterRefreshFailure(error), isTrue);
      });
    }

    for (final status in [403, 429, 500, 503]) {
      test('retains tokens after HTTP $status from refresh', () {
        final request = RequestOptions(path: 'token/refresh/');
        final error = DioException(
          requestOptions: request,
          response: Response<void>(requestOptions: request, statusCode: status),
        );

        expect(shouldLogoutAfterRefreshFailure(error), isFalse);
      });
    }

    test('retains tokens after a temporary network failure', () {
      final error = DioException(
        requestOptions: RequestOptions(path: 'token/refresh/'),
        type: DioExceptionType.connectionError,
      );

      expect(shouldLogoutAfterRefreshFailure(error), isFalse);
    });

    test('retains tokens after a timeout', () {
      final error = DioException(
        requestOptions: RequestOptions(path: 'token/refresh/'),
        type: DioExceptionType.receiveTimeout,
      );

      expect(shouldLogoutAfterRefreshFailure(error), isFalse);
    });

    test('retains tokens after an unexpected local parsing failure', () {
      expect(
        shouldLogoutAfterRefreshFailure(const FormatException('bad payload')),
        isFalse,
      );
    });
  });
}
