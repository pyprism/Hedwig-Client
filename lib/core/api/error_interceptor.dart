import 'package:dio/dio.dart';
import 'package:hedwig_client/core/error/failure.dart';

class ApiException implements Exception {
  const ApiException(this.failure);
  final Failure failure;

  @override
  String toString() => failure.userMessage;
}

/// Converts any caught exception to a [Failure] for display in the UI.
Failure failureFromError(Object e) {
  if (e is ApiException) return e.failure;
  if (e is Failure) return e;
  return Failure.unknown(message: e.toString());
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _map(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        error: ApiException(failure),
        type: err.type,
      ),
    );
  }

  Failure _map(DioException err) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return const Failure.network(
        message: 'Check your connection and try again.',
      );
    }

    final status = err.response?.statusCode;
    if (status == null) {
      return Failure.unknown(message: err.message ?? 'Unexpected error.');
    }

    final data = err.response?.data;
    final detail = _extractDetail(data);

    return switch (status) {
      401 => const Failure.auth(),
      403 => Failure.server(
        statusCode: status,
        message: detail ?? 'Access denied.',
      ),
      404 => Failure.notFound(message: detail),
      429 => const Failure.server(
        statusCode: 429,
        message: 'Too many requests. Please wait and try again.',
      ),
      _ => Failure.server(
        statusCode: status,
        message: detail ?? 'Server error ($status).',
        fieldErrors: _extractFieldErrors(data),
      ),
    };
  }

  String? _extractDetail(dynamic data) {
    if (data is Map<String, dynamic>) {
      final d = data['detail'];
      if (d is String) return d;
      // Some DRF errors: {"non_field_errors": ["..."]}
      final nfe = data['non_field_errors'];
      if (nfe is List && nfe.isNotEmpty) return nfe.first.toString();
    }
    return null;
  }

  Map<String, dynamic> _extractFieldErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      return Map<String, dynamic>.fromEntries(
        data.entries.where((e) => e.key != 'detail' && e.value is List),
      );
    }
    return {};
  }
}
