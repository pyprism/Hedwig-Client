import 'package:freezed_annotation/freezed_annotation.dart';

part 'mailbox.freezed.dart';
part 'mailbox.g.dart';

@freezed
class Mailbox with _$Mailbox {
  const factory Mailbox({
    required String id,
    @JsonKey(name: 'domain') required String domainId,
    required String localPart,
    required String emailAddress,
    String? displayName,
    @Default(true) bool sendEnabled,
    @Default(true) bool receiveEnabled,
    @Default(true) bool isActive,
    @Default(0) int quotaBytes,
    @Default(0) int usedBytes,
    String? signatureHtml,
    String? signatureText,
    DateTime? updatedAt,
  }) = _Mailbox;

  factory Mailbox.fromJson(Map<String, dynamic> json) =>
      _$MailboxFromJson(json);
}
