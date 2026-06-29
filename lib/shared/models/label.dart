import 'package:freezed_annotation/freezed_annotation.dart';

part 'label.freezed.dart';
part 'label.g.dart';

@freezed
abstract class Label with _$Label {
  const factory Label({
    required String id,
    @JsonKey(name: 'mailbox') required String mailboxId,
    required String name,
    String? color,
    DateTime? createdAt,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}
