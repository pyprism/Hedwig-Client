import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

const _kAccessToken = 'access_token';
const _kRefreshToken = 'refresh_token';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage(ref.watch(secureStorageProvider));
}

class TokenStorage {
  const TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> getAccessToken() => _readResilient(_kAccessToken);
  Future<String?> getRefreshToken() => _readResilient(_kRefreshToken);

  // On web, flutter_secure_storage encrypts values with AES-GCM. A stale or
  // mismatched entry (e.g. left over from a previous build/key) makes read()
  // throw a Web Crypto "OperationError", which otherwise propagates up through
  // the auth interceptor and aborts the request before it is even sent. Treat
  // an unreadable token as absent and drop the corrupt entry so the app
  // self-heals: the user is sent to login and writes a fresh, valid token.
  Future<String?> _readResilient(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      debugPrint('[TokenStorage] unreadable "$key" ($e) — clearing it');
      try {
        await _storage.delete(key: key);
      } catch (_) {}
      return null;
    }
  }

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await Future.wait([
      _storage.write(key: _kAccessToken, value: access),
      _storage.write(key: _kRefreshToken, value: refresh),
    ]);
  }

  Future<void> clearTokens() async {
    try {
      await Future.wait([
        _storage.delete(key: _kAccessToken),
        _storage.delete(key: _kRefreshToken),
      ]);
    } catch (e) {
      debugPrint('[TokenStorage] clearTokens failed: $e');
    }
  }
}
