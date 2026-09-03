import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/error/failure.dart';

/// Fakes a fixed HTTP response so we can drive real DioException/interceptor
/// plumbing (headers included) without a network call.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter({required this.statusCode, this.headers = const {}});

  final int statusCode;
  final Map<String, List<String>> headers;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString('{}', statusCode, headers: headers);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('ErrorInterceptor Retry-After', () {
    test(
      '429 with a Retry-After header parses seconds onto the Failure',
      () async {
        final dio = Dio();
        dio.httpClientAdapter = _FakeAdapter(
          statusCode: 429,
          headers: {
            'retry-after': ['42'],
          },
        );
        dio.interceptors.add(ErrorInterceptor());

        try {
          await dio.get('https://example.test/');
          fail('expected a DioException');
        } on DioException catch (e) {
          final failure = failureFromError(e.error!);
          expect(failure, isA<ServerFailure>());
          final server = failure as ServerFailure;
          expect(server.statusCode, 429);
          expect(server.retryAfterSeconds, 42);
          expect(failure.userMessage, contains('42s'));
        }
      },
    );

    test(
      '429 with no Retry-After header leaves retryAfterSeconds null',
      () async {
        final dio = Dio();
        dio.httpClientAdapter = _FakeAdapter(statusCode: 429);
        dio.interceptors.add(ErrorInterceptor());

        try {
          await dio.get('https://example.test/');
          fail('expected a DioException');
        } on DioException catch (e) {
          final failure = failureFromError(e.error!) as ServerFailure;
          expect(failure.retryAfterSeconds, isNull);
        }
      },
    );
  });
}
