// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HedwigUser _$HedwigUserFromJson(Map<String, dynamic> json) => _HedwigUser(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  timezone: json['timezone'] as String?,
  locale: json['locale'] as String?,
  mustChangePassword: json['must_change_password'] as bool? ?? false,
  isStaff: json['is_staff'] as bool? ?? false,
  isSuperuser: json['is_superuser'] as bool? ?? false,
  lastSeenAt: json['last_seen_at'] == null
      ? null
      : DateTime.parse(json['last_seen_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$HedwigUserToJson(_HedwigUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'display_name': instance.displayName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar_url': instance.avatarUrl,
      'timezone': instance.timezone,
      'locale': instance.locale,
      'must_change_password': instance.mustChangePassword,
      'is_staff': instance.isStaff,
      'is_superuser': instance.isSuperuser,
      'last_seen_at': instance.lastSeenAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
