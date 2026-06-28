// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mailbox.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Mailbox _$MailboxFromJson(Map<String, dynamic> json) {
  return _Mailbox.fromJson(json);
}

/// @nodoc
mixin _$Mailbox {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'domain')
  String get domainId => throw _privateConstructorUsedError;
  String get localPart => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool get sendEnabled => throw _privateConstructorUsedError;
  bool get receiveEnabled => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get quotaBytes => throw _privateConstructorUsedError;
  int get usedBytes => throw _privateConstructorUsedError;
  String? get signatureHtml => throw _privateConstructorUsedError;
  String? get signatureText => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Mailbox to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mailbox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MailboxCopyWith<Mailbox> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailboxCopyWith<$Res> {
  factory $MailboxCopyWith(Mailbox value, $Res Function(Mailbox) then) =
      _$MailboxCopyWithImpl<$Res, Mailbox>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'domain') String domainId,
    String localPart,
    String emailAddress,
    String? displayName,
    bool sendEnabled,
    bool receiveEnabled,
    bool isActive,
    int quotaBytes,
    int usedBytes,
    String? signatureHtml,
    String? signatureText,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$MailboxCopyWithImpl<$Res, $Val extends Mailbox>
    implements $MailboxCopyWith<$Res> {
  _$MailboxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mailbox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? domainId = null,
    Object? localPart = null,
    Object? emailAddress = null,
    Object? displayName = freezed,
    Object? sendEnabled = null,
    Object? receiveEnabled = null,
    Object? isActive = null,
    Object? quotaBytes = null,
    Object? usedBytes = null,
    Object? signatureHtml = freezed,
    Object? signatureText = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            domainId: null == domainId
                ? _value.domainId
                : domainId // ignore: cast_nullable_to_non_nullable
                      as String,
            localPart: null == localPart
                ? _value.localPart
                : localPart // ignore: cast_nullable_to_non_nullable
                      as String,
            emailAddress: null == emailAddress
                ? _value.emailAddress
                : emailAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            sendEnabled: null == sendEnabled
                ? _value.sendEnabled
                : sendEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            receiveEnabled: null == receiveEnabled
                ? _value.receiveEnabled
                : receiveEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            quotaBytes: null == quotaBytes
                ? _value.quotaBytes
                : quotaBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            usedBytes: null == usedBytes
                ? _value.usedBytes
                : usedBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            signatureHtml: freezed == signatureHtml
                ? _value.signatureHtml
                : signatureHtml // ignore: cast_nullable_to_non_nullable
                      as String?,
            signatureText: freezed == signatureText
                ? _value.signatureText
                : signatureText // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$MailboxImplCopyWith<$Res> implements $MailboxCopyWith<$Res> {
  factory _$$MailboxImplCopyWith(
    _$MailboxImpl value,
    $Res Function(_$MailboxImpl) then,
  ) = __$$MailboxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'domain') String domainId,
    String localPart,
    String emailAddress,
    String? displayName,
    bool sendEnabled,
    bool receiveEnabled,
    bool isActive,
    int quotaBytes,
    int usedBytes,
    String? signatureHtml,
    String? signatureText,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$MailboxImplCopyWithImpl<$Res>
    extends _$MailboxCopyWithImpl<$Res, _$MailboxImpl>
    implements _$$MailboxImplCopyWith<$Res> {
  __$$MailboxImplCopyWithImpl(
    _$MailboxImpl _value,
    $Res Function(_$MailboxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Mailbox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? domainId = null,
    Object? localPart = null,
    Object? emailAddress = null,
    Object? displayName = freezed,
    Object? sendEnabled = null,
    Object? receiveEnabled = null,
    Object? isActive = null,
    Object? quotaBytes = null,
    Object? usedBytes = null,
    Object? signatureHtml = freezed,
    Object? signatureText = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$MailboxImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        domainId: null == domainId
            ? _value.domainId
            : domainId // ignore: cast_nullable_to_non_nullable
                  as String,
        localPart: null == localPart
            ? _value.localPart
            : localPart // ignore: cast_nullable_to_non_nullable
                  as String,
        emailAddress: null == emailAddress
            ? _value.emailAddress
            : emailAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        sendEnabled: null == sendEnabled
            ? _value.sendEnabled
            : sendEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        receiveEnabled: null == receiveEnabled
            ? _value.receiveEnabled
            : receiveEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        quotaBytes: null == quotaBytes
            ? _value.quotaBytes
            : quotaBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        usedBytes: null == usedBytes
            ? _value.usedBytes
            : usedBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        signatureHtml: freezed == signatureHtml
            ? _value.signatureHtml
            : signatureHtml // ignore: cast_nullable_to_non_nullable
                  as String?,
        signatureText: freezed == signatureText
            ? _value.signatureText
            : signatureText // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$MailboxImpl implements _Mailbox {
  const _$MailboxImpl({
    required this.id,
    @JsonKey(name: 'domain') required this.domainId,
    required this.localPart,
    required this.emailAddress,
    this.displayName,
    this.sendEnabled = true,
    this.receiveEnabled = true,
    this.isActive = true,
    this.quotaBytes = 0,
    this.usedBytes = 0,
    this.signatureHtml,
    this.signatureText,
    this.updatedAt,
  });

  factory _$MailboxImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailboxImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'domain')
  final String domainId;
  @override
  final String localPart;
  @override
  final String emailAddress;
  @override
  final String? displayName;
  @override
  @JsonKey()
  final bool sendEnabled;
  @override
  @JsonKey()
  final bool receiveEnabled;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int quotaBytes;
  @override
  @JsonKey()
  final int usedBytes;
  @override
  final String? signatureHtml;
  @override
  final String? signatureText;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Mailbox(id: $id, domainId: $domainId, localPart: $localPart, emailAddress: $emailAddress, displayName: $displayName, sendEnabled: $sendEnabled, receiveEnabled: $receiveEnabled, isActive: $isActive, quotaBytes: $quotaBytes, usedBytes: $usedBytes, signatureHtml: $signatureHtml, signatureText: $signatureText, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailboxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.domainId, domainId) ||
                other.domainId == domainId) &&
            (identical(other.localPart, localPart) ||
                other.localPart == localPart) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.sendEnabled, sendEnabled) ||
                other.sendEnabled == sendEnabled) &&
            (identical(other.receiveEnabled, receiveEnabled) ||
                other.receiveEnabled == receiveEnabled) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.quotaBytes, quotaBytes) ||
                other.quotaBytes == quotaBytes) &&
            (identical(other.usedBytes, usedBytes) ||
                other.usedBytes == usedBytes) &&
            (identical(other.signatureHtml, signatureHtml) ||
                other.signatureHtml == signatureHtml) &&
            (identical(other.signatureText, signatureText) ||
                other.signatureText == signatureText) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    domainId,
    localPart,
    emailAddress,
    displayName,
    sendEnabled,
    receiveEnabled,
    isActive,
    quotaBytes,
    usedBytes,
    signatureHtml,
    signatureText,
    updatedAt,
  );

  /// Create a copy of Mailbox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MailboxImplCopyWith<_$MailboxImpl> get copyWith =>
      __$$MailboxImplCopyWithImpl<_$MailboxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailboxImplToJson(this);
  }
}

abstract class _Mailbox implements Mailbox {
  const factory _Mailbox({
    required final String id,
    @JsonKey(name: 'domain') required final String domainId,
    required final String localPart,
    required final String emailAddress,
    final String? displayName,
    final bool sendEnabled,
    final bool receiveEnabled,
    final bool isActive,
    final int quotaBytes,
    final int usedBytes,
    final String? signatureHtml,
    final String? signatureText,
    final DateTime? updatedAt,
  }) = _$MailboxImpl;

  factory _Mailbox.fromJson(Map<String, dynamic> json) = _$MailboxImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'domain')
  String get domainId;
  @override
  String get localPart;
  @override
  String get emailAddress;
  @override
  String? get displayName;
  @override
  bool get sendEnabled;
  @override
  bool get receiveEnabled;
  @override
  bool get isActive;
  @override
  int get quotaBytes;
  @override
  int get usedBytes;
  @override
  String? get signatureHtml;
  @override
  String? get signatureText;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Mailbox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MailboxImplCopyWith<_$MailboxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
