// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HedwigUser {

 String get id; String get username; String get email; String? get displayName; String? get firstName; String? get lastName; String? get avatarUrl; String? get timezone; String? get locale; bool get mustChangePassword; bool get isStaff; bool get isSuperuser; DateTime? get lastSeenAt; DateTime? get createdAt;
/// Create a copy of HedwigUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HedwigUserCopyWith<HedwigUser> get copyWith => _$HedwigUserCopyWithImpl<HedwigUser>(this as HedwigUser, _$identity);

  /// Serializes this HedwigUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HedwigUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.isSuperuser, isSuperuser) || other.isSuperuser == isSuperuser)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,email,displayName,firstName,lastName,avatarUrl,timezone,locale,mustChangePassword,isStaff,isSuperuser,lastSeenAt,createdAt);

@override
String toString() {
  return 'HedwigUser(id: $id, username: $username, email: $email, displayName: $displayName, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, timezone: $timezone, locale: $locale, mustChangePassword: $mustChangePassword, isStaff: $isStaff, isSuperuser: $isSuperuser, lastSeenAt: $lastSeenAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HedwigUserCopyWith<$Res>  {
  factory $HedwigUserCopyWith(HedwigUser value, $Res Function(HedwigUser) _then) = _$HedwigUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String email, String? displayName, String? firstName, String? lastName, String? avatarUrl, String? timezone, String? locale, bool mustChangePassword, bool isStaff, bool isSuperuser, DateTime? lastSeenAt, DateTime? createdAt
});




}
/// @nodoc
class _$HedwigUserCopyWithImpl<$Res>
    implements $HedwigUserCopyWith<$Res> {
  _$HedwigUserCopyWithImpl(this._self, this._then);

  final HedwigUser _self;
  final $Res Function(HedwigUser) _then;

/// Create a copy of HedwigUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? email = null,Object? displayName = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? avatarUrl = freezed,Object? timezone = freezed,Object? locale = freezed,Object? mustChangePassword = null,Object? isStaff = null,Object? isSuperuser = null,Object? lastSeenAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,isSuperuser: null == isSuperuser ? _self.isSuperuser : isSuperuser // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HedwigUser].
extension HedwigUserPatterns on HedwigUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HedwigUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HedwigUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HedwigUser value)  $default,){
final _that = this;
switch (_that) {
case _HedwigUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HedwigUser value)?  $default,){
final _that = this;
switch (_that) {
case _HedwigUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String email,  String? displayName,  String? firstName,  String? lastName,  String? avatarUrl,  String? timezone,  String? locale,  bool mustChangePassword,  bool isStaff,  bool isSuperuser,  DateTime? lastSeenAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HedwigUser() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.displayName,_that.firstName,_that.lastName,_that.avatarUrl,_that.timezone,_that.locale,_that.mustChangePassword,_that.isStaff,_that.isSuperuser,_that.lastSeenAt,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String email,  String? displayName,  String? firstName,  String? lastName,  String? avatarUrl,  String? timezone,  String? locale,  bool mustChangePassword,  bool isStaff,  bool isSuperuser,  DateTime? lastSeenAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _HedwigUser():
return $default(_that.id,_that.username,_that.email,_that.displayName,_that.firstName,_that.lastName,_that.avatarUrl,_that.timezone,_that.locale,_that.mustChangePassword,_that.isStaff,_that.isSuperuser,_that.lastSeenAt,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String email,  String? displayName,  String? firstName,  String? lastName,  String? avatarUrl,  String? timezone,  String? locale,  bool mustChangePassword,  bool isStaff,  bool isSuperuser,  DateTime? lastSeenAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HedwigUser() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.displayName,_that.firstName,_that.lastName,_that.avatarUrl,_that.timezone,_that.locale,_that.mustChangePassword,_that.isStaff,_that.isSuperuser,_that.lastSeenAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HedwigUser implements HedwigUser {
  const _HedwigUser({required this.id, required this.username, required this.email, this.displayName, this.firstName, this.lastName, this.avatarUrl, this.timezone, this.locale, this.mustChangePassword = false, this.isStaff = false, this.isSuperuser = false, this.lastSeenAt, this.createdAt});
  factory _HedwigUser.fromJson(Map<String, dynamic> json) => _$HedwigUserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String email;
@override final  String? displayName;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? avatarUrl;
@override final  String? timezone;
@override final  String? locale;
@override@JsonKey() final  bool mustChangePassword;
@override@JsonKey() final  bool isStaff;
@override@JsonKey() final  bool isSuperuser;
@override final  DateTime? lastSeenAt;
@override final  DateTime? createdAt;

/// Create a copy of HedwigUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HedwigUserCopyWith<_HedwigUser> get copyWith => __$HedwigUserCopyWithImpl<_HedwigUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HedwigUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HedwigUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.isSuperuser, isSuperuser) || other.isSuperuser == isSuperuser)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,email,displayName,firstName,lastName,avatarUrl,timezone,locale,mustChangePassword,isStaff,isSuperuser,lastSeenAt,createdAt);

@override
String toString() {
  return 'HedwigUser(id: $id, username: $username, email: $email, displayName: $displayName, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, timezone: $timezone, locale: $locale, mustChangePassword: $mustChangePassword, isStaff: $isStaff, isSuperuser: $isSuperuser, lastSeenAt: $lastSeenAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HedwigUserCopyWith<$Res> implements $HedwigUserCopyWith<$Res> {
  factory _$HedwigUserCopyWith(_HedwigUser value, $Res Function(_HedwigUser) _then) = __$HedwigUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String email, String? displayName, String? firstName, String? lastName, String? avatarUrl, String? timezone, String? locale, bool mustChangePassword, bool isStaff, bool isSuperuser, DateTime? lastSeenAt, DateTime? createdAt
});




}
/// @nodoc
class __$HedwigUserCopyWithImpl<$Res>
    implements _$HedwigUserCopyWith<$Res> {
  __$HedwigUserCopyWithImpl(this._self, this._then);

  final _HedwigUser _self;
  final $Res Function(_HedwigUser) _then;

/// Create a copy of HedwigUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? email = null,Object? displayName = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? avatarUrl = freezed,Object? timezone = freezed,Object? locale = freezed,Object? mustChangePassword = null,Object? isStaff = null,Object? isSuperuser = null,Object? lastSeenAt = freezed,Object? createdAt = freezed,}) {
  return _then(_HedwigUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,isSuperuser: null == isSuperuser ? _self.isSuperuser : isSuperuser // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
