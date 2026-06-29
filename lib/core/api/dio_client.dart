import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hedwig_client/core/api/auth_interceptor.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/config/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final baseUrl = ref.watch(appConfigProvider) ?? '';
  final dio = Dio(
    BaseOptions(
      baseUrl: '$baseUrl/api/',
      contentType: 'application/json',
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.addAll([
    ref.watch(authInterceptorProvider),
    ErrorInterceptor(),
  ]);

  // Dev-only wire log: makes every request/response/error visible in the
  // console so a "nothing happened" click can be traced to its actual cause.
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
  }

  return dio;
}
