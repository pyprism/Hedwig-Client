// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HedwigUser _$HedwigUserFromJson(Map<String, dynamic> json) {
  return _HedwigUser.fromJson(json);
}

/// @nodoc
mixin _$HedwigUser {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  String? get locale => throw _privateConstructorUsedError;
  bool get mustChangePassword => throw _privateConstructorUsedError;
  bool get isStaff => throw _privateConstructorUsedError;
  bool get isSuperuser => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this HedwigUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HedwigUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HedwigUserCopyWith<HedwigUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HedwigUserCopyWith<$Res> {
  factory $HedwigUserCopyWith(
    HedwigUser value,
    $Res Function(HedwigUser) then,
  ) = _$HedwigUserCopyWithImpl<$Res, HedwigUser>;
  @useResult
  $Res call({
    String id,
    String username,
    String email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? timezone,
    String? locale,
    bool mustChangePassword,
    bool isStaff,
    bool isSuperuser,
    DateTime? lastSeenAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$HedwigUserCopyWithImpl<$Res, $Val extends HedwigUser>
    implements $HedwigUserCopyWith<$Res> {
  _$HedwigUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HedwigUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? avatarUrl = freezed,
    Object? timezone = freezed,
    Object? locale = freezed,
    Object? mustChangePassword = null,
    Object? isStaff = null,
    Object? isSuperuser = null,
    Object? lastSeenAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            locale: freezed == locale
                ? _value.locale
                : locale // ignore: cast_nullable_to_non_nullable
                      as String?,
            mustChangePassword: null == mustChangePassword
                ? _value.mustChangePassword
                : mustChangePassword // ignore: cast_nullable_to_non_nullable
                      as bool,
            isStaff: null == isStaff
                ? _value.isStaff
                : isStaff // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSuperuser: null == isSuperuser
                ? _value.isSuperuser
                : isSuperuser // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSeenAt: freezed == lastSeenAt
                ? _value.lastSeenAt
                : lastSeenAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HedwigUserImplCopyWith<$Res>
    implements $HedwigUserCopyWith<$Res> {
  factory _$$HedwigUserImplCopyWith(
    _$HedwigUserImpl value,
    $Res Function(_$HedwigUserImpl) then,
  ) = __$$HedwigUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String username,
    String email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? timezone,
    String? locale,
    bool mustChangePassword,
    bool isStaff,
    bool isSuperuser,
    DateTime? lastSeenAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$HedwigUserImplCopyWithImpl<$Res>
    extends _$HedwigUserCopyWithImpl<$Res, _$HedwigUserImpl>
    implements _$$HedwigUserImplCopyWith<$Res> {
  __$$HedwigUserImplCopyWithImpl(
    _$HedwigUserImpl _value,
    $Res Function(_$HedwigUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HedwigUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? avatarUrl = freezed,
    Object? timezone = freezed,
    Object? locale = freezed,
    Object? mustChangePassword = null,
    Object? isStaff = null,
    Object? isSuperuser = null,
    Object? lastSeenAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$HedwigUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        locale: freezed == locale
            ? _value.locale
            : locale // ignore: cast_nullable_to_non_nullable
                  as String?,
        mustChangePassword: null == mustChangePassword
            ? _value.mustChangePassword
            : mustChangePassword // ignore: cast_nullable_to_non_nullable
                  as bool,
        isStaff: null == isStaff
            ? _value.isStaff
            : isStaff // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSuperuser: null == isSuperuser
            ? _value.isSuperuser
            : isSuperuser // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSeenAt: freezed == lastSeenAt
            ? _value.lastSeenAt
            : lastSeenAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HedwigUserImpl implements _HedwigUser {
  const _$HedwigUserImpl({
    required this.id,
    required this.username,
    required this.email,
    this.displayName,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.timezone,
    this.locale,
    this.mustChangePassword = false,
    this.isStaff = false,
    this.isSuperuser = false,
    this.lastSeenAt,
    this.createdAt,
  });

  factory _$HedwigUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$HedwigUserImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? avatarUrl;
  @override
  final String? timezone;
  @override
  final String? locale;
  @override
  @JsonKey()
  final bool mustChangePassword;
  @override
  @JsonKey()
  final bool isStaff;
  @override
  @JsonKey()
  final bool isSuperuser;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'HedwigUser(id: $id, username: $username, email: $email, displayName: $displayName, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, timezone: $timezone, locale: $locale, mustChangePassword: $mustChangePassword, isStaff: $isStaff, isSuperuser: $isSuperuser, lastSeenAt: $lastSeenAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HedwigUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.mustChangePassword, mustChangePassword) ||
                other.mustChangePassword == mustChangePassword) &&
            (identical(other.isStaff, isStaff) || other.isStaff == isStaff) &&
            (identical(other.isSuperuser, isSuperuser) ||
                other.isSuperuser == isSuperuser) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    email,
    displayName,
    firstName,
    lastName,
    avatarUrl,
    timezone,
    locale,
    mustChangePassword,
    isStaff,
    isSuperuser,
    lastSeenAt,
    createdAt,
  );

  /// Create a copy of HedwigUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HedwigUserImplCopyWith<_$HedwigUserImpl> get copyWith =>
      __$$HedwigUserImplCopyWithImpl<_$HedwigUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HedwigUserImplToJson(this);
  }
}

abstract class _HedwigUser implements HedwigUser {
  const factory _HedwigUser({
    required final String id,
    required final String username,
    required final String email,
    final String? displayName,
    final String? firstName,
    final String? lastName,
    final String? avatarUrl,
    final String? timezone,
    final String? locale,
    final bool mustChangePassword,
    final bool isStaff,
    final bool isSuperuser,
    final DateTime? lastSeenAt,
    final DateTime? createdAt,
  }) = _$HedwigUserImpl;

  factory _HedwigUser.fromJson(Map<String, dynamic> json) =
      _$HedwigUserImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get avatarUrl;
  @override
  String? get timezone;
  @override
  String? get locale;
  @override
  bool get mustChangePassword;
  @override
  bool get isStaff;
  @override
  bool get isSuperuser;
  @override
  DateTime? get lastSeenAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of HedwigUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HedwigUserImplCopyWith<_$HedwigUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
