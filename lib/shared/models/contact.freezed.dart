// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return _Contact.fromJson(json);
}

/// @nodoc
mixin _$Contact {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mailbox')
  String get mailboxId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  int get timesContacted => throw _privateConstructorUsedError;
  DateTime? get lastContactedAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res, Contact>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'mailbox') String mailboxId,
    String email,
    String? name,
    bool isFavorite,
    int timesContacted,
    DateTime? lastContactedAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ContactCopyWithImpl<$Res, $Val extends Contact>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mailboxId = null,
    Object? email = null,
    Object? name = freezed,
    Object? isFavorite = null,
    Object? timesContacted = null,
    Object? lastContactedAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mailboxId: null == mailboxId
                ? _value.mailboxId
                : mailboxId // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            timesContacted: null == timesContacted
                ? _value.timesContacted
                : timesContacted // ignore: cast_nullable_to_non_nullable
                      as int,
            lastContactedAt: freezed == lastContactedAt
                ? _value.lastContactedAt
                : lastContactedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactImplCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$$ContactImplCopyWith(
    _$ContactImpl value,
    $Res Function(_$ContactImpl) then,
  ) = __$$ContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'mailbox') String mailboxId,
    String email,
    String? name,
    bool isFavorite,
    int timesContacted,
    DateTime? lastContactedAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ContactImplCopyWithImpl<$Res>
    extends _$ContactCopyWithImpl<$Res, _$ContactImpl>
    implements _$$ContactImplCopyWith<$Res> {
  __$$ContactImplCopyWithImpl(
    _$ContactImpl _value,
    $Res Function(_$ContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mailboxId = null,
    Object? email = null,
    Object? name = freezed,
    Object? isFavorite = null,
    Object? timesContacted = null,
    Object? lastContactedAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ContactImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mailboxId: null == mailboxId
            ? _value.mailboxId
            : mailboxId // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        timesContacted: null == timesContacted
            ? _value.timesContacted
            : timesContacted // ignore: cast_nullable_to_non_nullable
                  as int,
        lastContactedAt: freezed == lastContactedAt
            ? _value.lastContactedAt
            : lastContactedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactImpl implements _Contact {
  const _$ContactImpl({
    required this.id,
    @JsonKey(name: 'mailbox') required this.mailboxId,
    required this.email,
    this.name,
    this.isFavorite = false,
    this.timesContacted = 0,
    this.lastContactedAt,
    this.updatedAt,
  });

  factory _$ContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'mailbox')
  final String mailboxId;
  @override
  final String email;
  @override
  final String? name;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  @JsonKey()
  final int timesContacted;
  @override
  final DateTime? lastContactedAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Contact(id: $id, mailboxId: $mailboxId, email: $email, name: $name, isFavorite: $isFavorite, timesContacted: $timesContacted, lastContactedAt: $lastContactedAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mailboxId, mailboxId) ||
                other.mailboxId == mailboxId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.timesContacted, timesContacted) ||
                other.timesContacted == timesContacted) &&
            (identical(other.lastContactedAt, lastContactedAt) ||
                other.lastContactedAt == lastContactedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    mailboxId,
    email,
    name,
    isFavorite,
    timesContacted,
    lastContactedAt,
    updatedAt,
  );

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      __$$ContactImplCopyWithImpl<_$ContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactImplToJson(this);
  }
}

abstract class _Contact implements Contact {
  const factory _Contact({
    required final String id,
    @JsonKey(name: 'mailbox') required final String mailboxId,
    required final String email,
    final String? name,
    final bool isFavorite,
    final int timesContacted,
    final DateTime? lastContactedAt,
    final DateTime? updatedAt,
  }) = _$ContactImpl;

  factory _Contact.fromJson(Map<String, dynamic> json) = _$ContactImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'mailbox')
  String get mailboxId;
  @override
  String get email;
  @override
  String? get name;
  @override
  bool get isFavorite;
  @override
  int get timesContacted;
  @override
  DateTime? get lastContactedAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
