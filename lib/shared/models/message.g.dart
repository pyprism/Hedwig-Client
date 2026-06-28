// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailAddressImpl _$$EmailAddressImplFromJson(Map<String, dynamic> json) =>
    _$EmailAddressImpl(
      email: json['email'] as String,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$$EmailAddressImplToJson(_$EmailAddressImpl instance) =>
    <String, dynamic>{'email': instance.email, 'name': instance.name};

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      id: json['id'] as String,
      filename: json['filename'] as String,
      contentType: json['content_type'] as String,
      sizeBytes: (json['size_bytes'] as num?)?.toInt() ?? 0,
      file: json['file'] as String?,
      isInline: json['is_inline'] as bool? ?? false,
      contentId: json['content_id'] as String?,
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'content_type': instance.contentType,
      'size_bytes': instance.sizeBytes,
      'file': instance.file,
      'is_inline': instance.isInline,
      'content_id': instance.contentId,
    };

_$MailMessageImpl _$$MailMessageImplFromJson(Map<String, dynamic> json) =>
    _$MailMessageImpl(
      id: json['id'] as String,
      mailboxId: json['mailbox'] as String,
      threadId: json['thread'] as String?,
      direction: json['direction'] as String,
      status: json['status'] as String,
      folder: json['folder'] as String? ?? 'inbox',
      fromAddress: json['from_address'] as String,
      fromName: json['from_name'] as String?,
      envelopeSender: json['envelope_sender'] as String?,
      envelopeRecipient: json['envelope_recipient'] as String?,
      toAddresses:
          (json['to_addresses'] as List<dynamic>?)
              ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ccAddresses:
          (json['cc_addresses'] as List<dynamic>?)
              ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bccAddresses:
          (json['bcc_addresses'] as List<dynamic>?)
              ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      replyTo: json['reply_to'] as String?,
      subject: json['subject'] as String,
      snippet: json['snippet'] as String?,
      bodyText: json['body_text'] as String?,
      bodyHtml: json['body_html'] as String?,
      rawMimeUrl: json['raw_mime_url'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      isStarred: json['is_starred'] as bool? ?? false,
      hasAttachments: json['has_attachments'] as bool? ?? false,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rawHeaders: json['raw_headers'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      receivedAt: json['received_at'] == null
          ? null
          : DateTime.parse(json['received_at'] as String),
      sentAt: json['sent_at'] == null
          ? null
          : DateTime.parse(json['sent_at'] as String),
      scheduledAt: json['scheduled_at'] == null
          ? null
          : DateTime.parse(json['scheduled_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$MailMessageImplToJson(_$MailMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mailbox': instance.mailboxId,
      'thread': instance.threadId,
      'direction': instance.direction,
      'status': instance.status,
      'folder': instance.folder,
      'from_address': instance.fromAddress,
      'from_name': instance.fromName,
      'envelope_sender': instance.envelopeSender,
      'envelope_recipient': instance.envelopeRecipient,
      'to_addresses': instance.toAddresses,
      'cc_addresses': instance.ccAddresses,
      'bcc_addresses': instance.bccAddresses,
      'reply_to': instance.replyTo,
      'subject': instance.subject,
      'snippet': instance.snippet,
      'body_text': instance.bodyText,
      'body_html': instance.bodyHtml,
      'raw_mime_url': instance.rawMimeUrl,
      'is_read': instance.isRead,
      'is_starred': instance.isStarred,
      'has_attachments': instance.hasAttachments,
      'attachments': instance.attachments,
      'raw_headers': instance.rawHeaders,
      'metadata': instance.metadata,
      'received_at': instance.receivedAt?.toIso8601String(),
      'sent_at': instance.sentAt?.toIso8601String(),
      'scheduled_at': instance.scheduledAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$SendMessageRequestImpl _$$SendMessageRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SendMessageRequestImpl(
  mailboxId: json['mailbox_id'] as String,
  senderIdentityId: json['sender_identity_id'] as String?,
  to: (json['to'] as List<dynamic>)
      .map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
      .toList(),
  cc:
      (json['cc'] as List<dynamic>?)
          ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  bcc:
      (json['bcc'] as List<dynamic>?)
          ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  subject: json['subject'] as String,
  bodyText: json['body_text'] as String?,
  bodyHtml: json['body_html'] as String?,
  replyToMessageId: json['reply_to_message_id'] as String?,
  scheduledAt: json['scheduled_at'] == null
      ? null
      : DateTime.parse(json['scheduled_at'] as String),
);

Map<String, dynamic> _$$SendMessageRequestImplToJson(
  _$SendMessageRequestImpl instance,
) => <String, dynamic>{
  'mailbox_id': instance.mailboxId,
  'sender_identity_id': instance.senderIdentityId,
  'to': instance.to,
  'cc': instance.cc,
  'bcc': instance.bcc,
  'subject': instance.subject,
  'body_text': instance.bodyText,
  'body_html': instance.bodyHtml,
  'reply_to_message_id': instance.replyToMessageId,
  'scheduled_at': instance.scheduledAt?.toIso8601String(),
};
