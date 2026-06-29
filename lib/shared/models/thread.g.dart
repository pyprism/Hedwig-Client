// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MailThreadImpl _$$MailThreadImplFromJson(Map<String, dynamic> json) =>
    _$MailThreadImpl(
      id: json['id'] as String,
      mailboxId: json['mailbox'] as String,
      subject: json['subject'] as String,
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      messageCount: (json['message_count'] as num?)?.toInt() ?? 0,
      hasUnread: json['has_unread'] as bool? ?? false,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      snippet: json['snippet'] as String?,
      latestDirection: json['latest_direction'] as String?,
      hasAttachments: json['has_attachments'] as bool? ?? false,
      attachmentFilenames:
          (json['attachment_filenames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      labels:
          (json['labels'] as List<dynamic>?)
              ?.map((e) => ThreadLabel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      searchHighlight: json['search_highlight'] as String?,
      lastMessageAt: json['last_message_at'] == null
          ? null
          : DateTime.parse(json['last_message_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$MailThreadImplToJson(_$MailThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mailbox': instance.mailboxId,
      'subject': instance.subject,
      'participants': instance.participants,
      'message_count': instance.messageCount,
      'has_unread': instance.hasUnread,
      'unread_count': instance.unreadCount,
      'snippet': instance.snippet,
      'latest_direction': instance.latestDirection,
      'has_attachments': instance.hasAttachments,
      'attachment_filenames': instance.attachmentFilenames,
      'labels': instance.labels,
      'search_highlight': instance.searchHighlight,
      'last_message_at': instance.lastMessageAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$ThreadLabelImpl _$$ThreadLabelImplFromJson(Map<String, dynamic> json) =>
    _$ThreadLabelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$ThreadLabelImplToJson(_$ThreadLabelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };
