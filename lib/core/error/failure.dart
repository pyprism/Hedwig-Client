import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.network({required String message}) = NetworkFailure;
  const factory Failure.server({
    required int statusCode,
    required String message,
    @Default({}) Map<String, dynamic> fieldErrors,
    // Parsed from a 429 response's `Retry-After` header (seconds). Lets a
    // caller disable a retry action or show a countdown for the advertised
    // window instead of allowing an immediate re-hit of the throttled
    // endpoint.
    int? retryAfterSeconds,
  }) = ServerFailure;
  const factory Failure.auth({String? message}) = AuthFailure;
  const factory Failure.notFound({String? message}) = NotFoundFailure;
  const factory Failure.unknown({required String message}) = UnknownFailure;
}

extension FailureMessage on Failure {
  String get userMessage => when(
    network: (msg) => 'No connection. $msg',
    server: (code, msg, _, retryAfterSeconds) => retryAfterSeconds != null
        ? '$msg Try again in ${retryAfterSeconds}s.'
        : msg,
    auth: (msg) => msg ?? 'Session expired. Please log in again.',
    notFound: (msg) => msg ?? 'Not found.',
    unknown: (msg) => msg,
  );
}
