// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mailbox.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Mailbox {

 String get id;@JsonKey(name: 'domain') String get domainId; String get localPart; String get emailAddress; String? get displayName; bool get sendEnabled; bool get receiveEnabled; bool get isActive; int get quotaBytes; int get usedBytes; String? get signatureHtml; String? get signatureText; DateTime? get updatedAt;
/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailboxCopyWith<Mailbox> get copyWith => _$MailboxCopyWithImpl<Mailbox>(this as Mailbox, _$identity);

  /// Serializes this Mailbox to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Mailbox&&(identical(other.id, id) || other.id == id)&&(identical(other.domainId, domainId) || other.domainId == domainId)&&(identical(other.localPart, localPart) || other.localPart == localPart)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sendEnabled, sendEnabled) || other.sendEnabled == sendEnabled)&&(identical(other.receiveEnabled, receiveEnabled) || other.receiveEnabled == receiveEnabled)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.quotaBytes, quotaBytes) || other.quotaBytes == quotaBytes)&&(identical(other.usedBytes, usedBytes) || other.usedBytes == usedBytes)&&(identical(other.signatureHtml, signatureHtml) || other.signatureHtml == signatureHtml)&&(identical(other.signatureText, signatureText) || other.signatureText == signatureText)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,domainId,localPart,emailAddress,displayName,sendEnabled,receiveEnabled,isActive,quotaBytes,usedBytes,signatureHtml,signatureText,updatedAt);

@override
String toString() {
  return 'Mailbox(id: $id, domainId: $domainId, localPart: $localPart, emailAddress: $emailAddress, displayName: $displayName, sendEnabled: $sendEnabled, receiveEnabled: $receiveEnabled, isActive: $isActive, quotaBytes: $quotaBytes, usedBytes: $usedBytes, signatureHtml: $signatureHtml, signatureText: $signatureText, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MailboxCopyWith<$Res>  {
  factory $MailboxCopyWith(Mailbox value, $Res Function(Mailbox) _then) = _$MailboxCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'domain') String domainId, String localPart, String emailAddress, String? displayName, bool sendEnabled, bool receiveEnabled, bool isActive, int quotaBytes, int usedBytes, String? signatureHtml, String? signatureText, DateTime? updatedAt
});




}
/// @nodoc
class _$MailboxCopyWithImpl<$Res>
    implements $MailboxCopyWith<$Res> {
  _$MailboxCopyWithImpl(this._self, this._then);

  final Mailbox _self;
  final $Res Function(Mailbox) _then;

/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? domainId = null,Object? localPart = null,Object? emailAddress = null,Object? displayName = freezed,Object? sendEnabled = null,Object? receiveEnabled = null,Object? isActive = null,Object? quotaBytes = null,Object? usedBytes = null,Object? signatureHtml = freezed,Object? signatureText = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,domainId: null == domainId ? _self.domainId : domainId // ignore: cast_nullable_to_non_nullable
as String,localPart: null == localPart ? _self.localPart : localPart // ignore: cast_nullable_to_non_nullable
as String,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,sendEnabled: null == sendEnabled ? _self.sendEnabled : sendEnabled // ignore: cast_nullable_to_non_nullable
as bool,receiveEnabled: null == receiveEnabled ? _self.receiveEnabled : receiveEnabled // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,quotaBytes: null == quotaBytes ? _self.quotaBytes : quotaBytes // ignore: cast_nullable_to_non_nullable
as int,usedBytes: null == usedBytes ? _self.usedBytes : usedBytes // ignore: cast_nullable_to_non_nullable
as int,signatureHtml: freezed == signatureHtml ? _self.signatureHtml : signatureHtml // ignore: cast_nullable_to_non_nullable
as String?,signatureText: freezed == signatureText ? _self.signatureText : signatureText // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Mailbox].
extension MailboxPatterns on Mailbox {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Mailbox value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Mailbox value)  $default,){
final _that = this;
switch (_that) {
case _Mailbox():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Mailbox value)?  $default,){
final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'domain')  String domainId,  String localPart,  String emailAddress,  String? displayName,  bool sendEnabled,  bool receiveEnabled,  bool isActive,  int quotaBytes,  int usedBytes,  String? signatureHtml,  String? signatureText,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
return $default(_that.id,_that.domainId,_that.localPart,_that.emailAddress,_that.displayName,_that.sendEnabled,_that.receiveEnabled,_that.isActive,_that.quotaBytes,_that.usedBytes,_that.signatureHtml,_that.signatureText,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'domain')  String domainId,  String localPart,  String emailAddress,  String? displayName,  bool sendEnabled,  bool receiveEnabled,  bool isActive,  int quotaBytes,  int usedBytes,  String? signatureHtml,  String? signatureText,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Mailbox():
return $default(_that.id,_that.domainId,_that.localPart,_that.emailAddress,_that.displayName,_that.sendEnabled,_that.receiveEnabled,_that.isActive,_that.quotaBytes,_that.usedBytes,_that.signatureHtml,_that.signatureText,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'domain')  String domainId,  String localPart,  String emailAddress,  String? displayName,  bool sendEnabled,  bool receiveEnabled,  bool isActive,  int quotaBytes,  int usedBytes,  String? signatureHtml,  String? signatureText,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Mailbox() when $default != null:
return $default(_that.id,_that.domainId,_that.localPart,_that.emailAddress,_that.displayName,_that.sendEnabled,_that.receiveEnabled,_that.isActive,_that.quotaBytes,_that.usedBytes,_that.signatureHtml,_that.signatureText,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Mailbox implements Mailbox {
  const _Mailbox({required this.id, @JsonKey(name: 'domain') required this.domainId, required this.localPart, required this.emailAddress, this.displayName, this.sendEnabled = true, this.receiveEnabled = true, this.isActive = true, this.quotaBytes = 0, this.usedBytes = 0, this.signatureHtml, this.signatureText, this.updatedAt});
  factory _Mailbox.fromJson(Map<String, dynamic> json) => _$MailboxFromJson(json);

@override final  String id;
@override@JsonKey(name: 'domain') final  String domainId;
@override final  String localPart;
@override final  String emailAddress;
@override final  String? displayName;
@override@JsonKey() final  bool sendEnabled;
@override@JsonKey() final  bool receiveEnabled;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int quotaBytes;
@override@JsonKey() final  int usedBytes;
@override final  String? signatureHtml;
@override final  String? signatureText;
@override final  DateTime? updatedAt;

/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailboxCopyWith<_Mailbox> get copyWith => __$MailboxCopyWithImpl<_Mailbox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MailboxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Mailbox&&(identical(other.id, id) || other.id == id)&&(identical(other.domainId, domainId) || other.domainId == domainId)&&(identical(other.localPart, localPart) || other.localPart == localPart)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sendEnabled, sendEnabled) || other.sendEnabled == sendEnabled)&&(identical(other.receiveEnabled, receiveEnabled) || other.receiveEnabled == receiveEnabled)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.quotaBytes, quotaBytes) || other.quotaBytes == quotaBytes)&&(identical(other.usedBytes, usedBytes) || other.usedBytes == usedBytes)&&(identical(other.signatureHtml, signatureHtml) || other.signatureHtml == signatureHtml)&&(identical(other.signatureText, signatureText) || other.signatureText == signatureText)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,domainId,localPart,emailAddress,displayName,sendEnabled,receiveEnabled,isActive,quotaBytes,usedBytes,signatureHtml,signatureText,updatedAt);

@override
String toString() {
  return 'Mailbox(id: $id, domainId: $domainId, localPart: $localPart, emailAddress: $emailAddress, displayName: $displayName, sendEnabled: $sendEnabled, receiveEnabled: $receiveEnabled, isActive: $isActive, quotaBytes: $quotaBytes, usedBytes: $usedBytes, signatureHtml: $signatureHtml, signatureText: $signatureText, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MailboxCopyWith<$Res> implements $MailboxCopyWith<$Res> {
  factory _$MailboxCopyWith(_Mailbox value, $Res Function(_Mailbox) _then) = __$MailboxCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'domain') String domainId, String localPart, String emailAddress, String? displayName, bool sendEnabled, bool receiveEnabled, bool isActive, int quotaBytes, int usedBytes, String? signatureHtml, String? signatureText, DateTime? updatedAt
});




}
/// @nodoc
class __$MailboxCopyWithImpl<$Res>
    implements _$MailboxCopyWith<$Res> {
  __$MailboxCopyWithImpl(this._self, this._then);

  final _Mailbox _self;
  final $Res Function(_Mailbox) _then;

/// Create a copy of Mailbox
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? domainId = null,Object? localPart = null,Object? emailAddress = null,Object? displayName = freezed,Object? sendEnabled = null,Object? receiveEnabled = null,Object? isActive = null,Object? quotaBytes = null,Object? usedBytes = null,Object? signatureHtml = freezed,Object? signatureText = freezed,Object? updatedAt = freezed,}) {
  return _then(_Mailbox(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,domainId: null == domainId ? _self.domainId : domainId // ignore: cast_nullable_to_non_nullable
as String,localPart: null == localPart ? _self.localPart : localPart // ignore: cast_nullable_to_non_nullable
as String,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,sendEnabled: null == sendEnabled ? _self.sendEnabled : sendEnabled // ignore: cast_nullable_to_non_nullable
as bool,receiveEnabled: null == receiveEnabled ? _self.receiveEnabled : receiveEnabled // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,quotaBytes: null == quotaBytes ? _self.quotaBytes : quotaBytes // ignore: cast_nullable_to_non_nullable
as int,usedBytes: null == usedBytes ? _self.usedBytes : usedBytes // ignore: cast_nullable_to_non_nullable
as int,signatureHtml: freezed == signatureHtml ? _self.signatureHtml : signatureHtml // ignore: cast_nullable_to_non_nullable
as String?,signatureText: freezed == signatureText ? _self.signatureText : signatureText // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
