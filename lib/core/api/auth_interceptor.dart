import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:hedwig_client/features/auth/presentation/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptor.g.dart';

@Riverpod(keepAlive: true)
AuthInterceptor authInterceptor(Ref ref) {
  return AuthInterceptor(ref);
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref);

  final Ref _ref;
  Completer<String>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isAuthEndpoint(options.path)) {
      handler.next(options);
      return;
    }
    final token = await _ref.read(tokenStorageProvider).getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 ||
        _isAuthEndpoint(err.requestOptions.path)) {
      handler.next(err);
      return;
    }

    try {
      // Concurrent 401s (e.g. several requests fired at once right after
      // navigating to /inbox) share one in-flight refresh instead of each
      // racing their own — only the first triggers a network call, the
      // rest await its result and retry with the new token.
      final newAccess = await _refreshAccessToken(err.requestOptions.baseUrl);

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccess';
      final retryDio = Dio(_bareOptions(err.requestOptions.baseUrl));
      final retryResponse = await retryDio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      await _logout();
      handler.next(err);
    }
  }

  // Interceptor-free dios used for refresh/retry must carry their own
  // timeouts. Without them a stalled refresh or retry hangs forever, and
  // because the original request already received its 401, dioClient's
  // timeouts no longer apply — the await here is what blocks. That was the
  // unbounded /inbox spinner.
  BaseOptions _bareOptions(String baseUrl) => BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );

  Future<String> _refreshAccessToken(String baseUrl) {
    final inFlight = _refreshCompleter;
    if (inFlight != null) return inFlight.future;

    final completer = Completer<String>();
    _refreshCompleter = completer;

    Future(() async {
      try {
        final storage = _ref.read(tokenStorageProvider);
        final refreshToken = await storage.getRefreshToken();
        if (refreshToken == null) {
          throw DioException(
            requestOptions: RequestOptions(path: 'token/refresh/'),
            error: 'No refresh token available',
          );
        }

        // Fresh Dio without our interceptors avoids infinite 401 retry loops.
        final refreshDio = Dio(_bareOptions(baseUrl));
        final response = await refreshDio.post(
          'token/refresh/',
          data: {'refresh': refreshToken},
        );

        final newAccess = response.data['access'] as String;
        final newRefresh = response.data['refresh'] as String;
        await storage.saveTokens(access: newAccess, refresh: newRefresh);
        completer.complete(newAccess);
      } catch (e) {
        completer.completeError(e);
      } finally {
        _refreshCompleter = null;
      }
    });

    return completer.future;
  }

  Future<void> _logout() async {
    await _ref.read(tokenStorageProvider).clearTokens();
    // authControllerProvider is keep-alive and reads the token once in build();
    // clearing tokens alone won't change its state. Invalidate so build() re-runs,
    // finds no access token, and emits unauthenticated — the router guard then
    // redirects to /login instead of leaving the user stranded on failing calls.
    _ref.invalidate(authControllerProvider);
  }

  bool _isAuthEndpoint(String path) {
    final normalized = path.startsWith('/') ? path.substring(1) : path;
    return normalized == 'token/' ||
        normalized == 'token/refresh/' ||
        normalized == 'token/blacklist/' ||
        normalized == 'accounts/users/register/';
  }
}
