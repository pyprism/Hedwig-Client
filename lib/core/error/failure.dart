import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.network({required String message}) = NetworkFailure;
  const factory Failure.server({
    required int statusCode,
    required String message,
    @Default({}) Map<String, dynamic> fieldErrors,
  }) = ServerFailure;
  const factory Failure.auth({String? message}) = AuthFailure;
  const factory Failure.notFound({String? message}) = NotFoundFailure;
  const factory Failure.unknown({required String message}) = UnknownFailure;
}

extension FailureMessage on Failure {
  String get userMessage => when(
        network: (msg) => 'No connection. $msg',
        server: (code, msg, _) => msg,
        auth: (msg) => msg ?? 'Session expired. Please log in again.',
        notFound: (msg) => msg ?? 'Not found.',
        unknown: (msg) => msg,
      );
}
