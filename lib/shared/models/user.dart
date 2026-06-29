import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class HedwigUser with _$HedwigUser {
  const factory HedwigUser({
    required String id,
    required String username,
    required String email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? timezone,
    String? locale,
    @Default(false) bool mustChangePassword,
    @Default(false) bool isStaff,
    @Default(false) bool isSuperuser,
    DateTime? lastSeenAt,
    DateTime? createdAt,
  }) = _HedwigUser;

  factory HedwigUser.fromJson(Map<String, dynamic> json) =>
      _$HedwigUserFromJson(json);
}
