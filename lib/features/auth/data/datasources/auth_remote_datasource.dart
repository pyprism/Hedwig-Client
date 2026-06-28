// ignore_for_file: use_null_aware_elements
import 'package:dio/dio.dart';
import 'package:hedwig_client/shared/models/token_pair.dart';
import 'package:hedwig_client/shared/models/user.dart';

class AuthRemoteDatasource {
  const AuthRemoteDatasource(this._dio);

  final Dio _dio;

  Future<TokenPair> login(String username, String password) async {
    final res = await _dio.post('token/', data: {
      'username': username,
      'password': password,
    });
    return TokenPair.fromJson(res.data as Map<String, dynamic>);
  }

  Future<HedwigUser> register({
    required String username,
    required String email,
    required String password,
    String? displayName,
    String? timezone,
    String? locale,
  }) async {
    final res = await _dio.post('accounts/users/register/', data: {
      'username': username,
      'email': email,
      'password': password,
      if (displayName != null) 'display_name': displayName,
      if (timezone != null) 'timezone': timezone,
      if (locale != null) 'locale': locale,
    });
    return HedwigUser.fromJson(res.data as Map<String, dynamic>);
  }

  Future<HedwigUser> getMe() async {
    final res = await _dio.get('accounts/users/me/');
    return HedwigUser.fromJson(res.data as Map<String, dynamic>);
  }

  Future<HedwigUser> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final res = await _dio.post('accounts/users/change-password/', data: {
      'current_password': currentPassword,
      'new_password': newPassword,
    });
    return HedwigUser.fromJson(res.data as Map<String, dynamic>);
  }

  Future<HedwigUser> patchMe({
    String? displayName,
    String? firstName,
    String? lastName,
    String? timezone,
    String? locale,
  }) async {
    final res = await _dio.patch('accounts/users/me/', data: {
      if (displayName != null) 'display_name': displayName,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (timezone != null) 'timezone': timezone,
      if (locale != null) 'locale': locale,
    });
    return HedwigUser.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post('token/blacklist/', data: {'refresh': refreshToken});
  }
}
