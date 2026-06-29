// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MailboxImpl _$$MailboxImplFromJson(Map<String, dynamic> json) =>
    _$MailboxImpl(
      id: json['id'] as String,
      domainId: json['domain'] as String,
      localPart: json['local_part'] as String,
      emailAddress: json['email_address'] as String,
      displayName: json['display_name'] as String?,
      sendEnabled: json['send_enabled'] as bool? ?? true,
      receiveEnabled: json['receive_enabled'] as bool? ?? true,
      isActive: json['is_active'] as bool? ?? true,
      quotaBytes: (json['quota_bytes'] as num?)?.toInt() ?? 0,
      usedBytes: (json['used_bytes'] as num?)?.toInt() ?? 0,
      signatureHtml: json['signature_html'] as String?,
      signatureText: json['signature_text'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MailboxImplToJson(_$MailboxImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'domain': instance.domainId,
      'local_part': instance.localPart,
      'email_address': instance.emailAddress,
      'display_name': instance.displayName,
      'send_enabled': instance.sendEnabled,
      'receive_enabled': instance.receiveEnabled,
      'is_active': instance.isActive,
      'quota_bytes': instance.quotaBytes,
      'used_bytes': instance.usedBytes,
      'signature_html': instance.signatureHtml,
      'signature_text': instance.signatureText,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
