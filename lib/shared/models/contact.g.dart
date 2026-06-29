// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactImpl _$$ContactImplFromJson(Map<String, dynamic> json) =>
    _$ContactImpl(
      id: json['id'] as String,
      mailboxId: json['mailbox'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      timesContacted: (json['times_contacted'] as num?)?.toInt() ?? 0,
      lastContactedAt: json['last_contacted_at'] == null
          ? null
          : DateTime.parse(json['last_contacted_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ContactImplToJson(_$ContactImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mailbox': instance.mailboxId,
      'email': instance.email,
      'name': instance.name,
      'is_favorite': instance.isFavorite,
      'times_contacted': instance.timesContacted,
      'last_contacted_at': instance.lastContactedAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
