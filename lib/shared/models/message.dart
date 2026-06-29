import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class EmailAddress with _$EmailAddress {
  const factory EmailAddress({
    required String email,
    @Default('') String name,
  }) = _EmailAddress;

  factory EmailAddress.fromJson(Map<String, dynamic> json) =>
      _$EmailAddressFromJson(json);
}

@freezed
abstract class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required String filename,
    required String contentType,
    @Default(0) int sizeBytes,
    String? file,
    @Default(false) bool isInline,
    String? contentId,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}

@freezed
abstract class MailMessage with _$MailMessage {
  const factory MailMessage({
    required String id,
    @JsonKey(name: 'mailbox') required String mailboxId,
    @JsonKey(name: 'thread') String? threadId,
    required String direction,
    required String status,
    @Default('inbox') String folder,
    required String fromAddress,
    String? fromName,
    String? envelopeSender,
    String? envelopeRecipient,
    @Default([]) List<EmailAddress> toAddresses,
    @Default([]) List<EmailAddress> ccAddresses,
    @Default([]) List<EmailAddress> bccAddresses,
    String? replyTo,
    required String subject,
    String? snippet,
    String? bodyText,
    String? bodyHtml,
    String? rawMimeUrl,
    @Default(false) bool isRead,
    @Default(false) bool isStarred,
    @Default(false) bool hasAttachments,
    @Default([]) List<Attachment> attachments,
    @Default({}) Map<String, dynamic> rawHeaders,
    @Default({}) Map<String, dynamic> metadata,
    DateTime? receivedAt,
    DateTime? sentAt,
    DateTime? scheduledAt,
    DateTime? createdAt,
  }) = _MailMessage;

  factory MailMessage.fromJson(Map<String, dynamic> json) =>
      _$MailMessageFromJson(json);
}

@freezed
abstract class SendMessageRequest with _$SendMessageRequest {
  const factory SendMessageRequest({
    required String mailboxId,
    String? senderIdentityId,
    required List<EmailAddress> to,
    @Default([]) List<EmailAddress> cc,
    @Default([]) List<EmailAddress> bcc,
    required String subject,
    String? bodyText,
    String? bodyHtml,
    String? replyToMessageId,
    DateTime? scheduledAt,
  }) = _SendMessageRequest;

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
}
