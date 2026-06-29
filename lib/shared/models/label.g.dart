// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Label _$LabelFromJson(Map<String, dynamic> json) => _Label(
  id: json['id'] as String,
  mailboxId: json['mailbox'] as String,
  name: json['name'] as String,
  color: json['color'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$LabelToJson(_Label instance) => <String, dynamic>{
  'id': instance.id,
  'mailbox': instance.mailboxId,
  'name': instance.name,
  'color': instance.color,
  'created_at': instance.createdAt?.toIso8601String(),
};
