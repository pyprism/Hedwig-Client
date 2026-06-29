import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:hedwig_client/shared/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_cache.g.dart';

const _kCachedUser = 'cached_user';

@Riverpod(keepAlive: true)
UserCache userCache(Ref ref) => UserCache(ref.watch(prefsStorageProvider));

class UserCache {
  const UserCache(this._prefs);

  final dynamic _prefs;

  Future<void> save(HedwigUser user) async {
    await _prefs.setString(_kCachedUser, jsonEncode(user.toJson()));
  }

  HedwigUser? load() {
    final raw = _prefs.getString(_kCachedUser) as String?;
    if (raw == null) return null;
    try {
      return HedwigUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> clear() => _prefs.remove(_kCachedUser);
}
