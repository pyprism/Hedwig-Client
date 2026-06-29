import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread.freezed.dart';
part 'thread.g.dart';

@freezed
abstract class MailThread with _$MailThread {
  const factory MailThread({
    required String id,
    @JsonKey(name: 'mailbox') required String mailboxId,
    required String subject,
    @Default([]) List<String> participants,
    @Default(0) int messageCount,
    @Default(false) bool hasUnread,
    @Default(0) int unreadCount,
    String? snippet,
    String? latestDirection,
    @Default(false) bool hasAttachments,
    @Default([]) List<String> attachmentFilenames,
    @Default([]) List<ThreadLabel> labels,
    String? searchHighlight,
    DateTime? lastMessageAt,
    DateTime? createdAt,
  }) = _MailThread;

  factory MailThread.fromJson(Map<String, dynamic> json) =>
      _$MailThreadFromJson(json);
}

@freezed
abstract class ThreadLabel with _$ThreadLabel {
  const factory ThreadLabel({
    required String id,
    required String name,
    String? color,
  }) = _ThreadLabel;

  factory ThreadLabel.fromJson(Map<String, dynamic> json) =>
      _$ThreadLabelFromJson(json);
}
