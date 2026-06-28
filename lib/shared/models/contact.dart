import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    @JsonKey(name: 'mailbox') required String mailboxId,
    required String email,
    String? name,
    @Default(false) bool isFavorite,
    @Default(0) int timesContacted,
    DateTime? lastContactedAt,
    DateTime? updatedAt,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
}
