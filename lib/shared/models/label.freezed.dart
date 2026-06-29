// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Label {

 String get id;@JsonKey(name: 'mailbox') String get mailboxId; String get name; String? get color; DateTime? get createdAt;
/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelCopyWith<Label> get copyWith => _$LabelCopyWithImpl<Label>(this as Label, _$identity);

  /// Serializes this Label to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Label&&(identical(other.id, id) || other.id == id)&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mailboxId,name,color,createdAt);

@override
String toString() {
  return 'Label(id: $id, mailboxId: $mailboxId, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LabelCopyWith<$Res>  {
  factory $LabelCopyWith(Label value, $Res Function(Label) _then) = _$LabelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'mailbox') String mailboxId, String name, String? color, DateTime? createdAt
});




}
/// @nodoc
class _$LabelCopyWithImpl<$Res>
    implements $LabelCopyWith<$Res> {
  _$LabelCopyWithImpl(this._self, this._then);

  final Label _self;
  final $Res Function(Label) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mailboxId = null,Object? name = null,Object? color = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Label].
extension LabelPatterns on Label {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Label value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Label() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Label value)  $default,){
final _that = this;
switch (_that) {
case _Label():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Label value)?  $default,){
final _that = this;
switch (_that) {
case _Label() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mailbox')  String mailboxId,  String name,  String? color,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Label() when $default != null:
return $default(_that.id,_that.mailboxId,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mailbox')  String mailboxId,  String name,  String? color,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Label():
return $default(_that.id,_that.mailboxId,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'mailbox')  String mailboxId,  String name,  String? color,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Label() when $default != null:
return $default(_that.id,_that.mailboxId,_that.name,_that.color,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Label implements Label {
  const _Label({required this.id, @JsonKey(name: 'mailbox') required this.mailboxId, required this.name, this.color, this.createdAt});
  factory _Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'mailbox') final  String mailboxId;
@override final  String name;
@override final  String? color;
@override final  DateTime? createdAt;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelCopyWith<_Label> get copyWith => __$LabelCopyWithImpl<_Label>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Label&&(identical(other.id, id) || other.id == id)&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mailboxId,name,color,createdAt);

@override
String toString() {
  return 'Label(id: $id, mailboxId: $mailboxId, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory _$LabelCopyWith(_Label value, $Res Function(_Label) _then) = __$LabelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'mailbox') String mailboxId, String name, String? color, DateTime? createdAt
});




}
/// @nodoc
class __$LabelCopyWithImpl<$Res>
    implements _$LabelCopyWith<$Res> {
  __$LabelCopyWithImpl(this._self, this._then);

  final _Label _self;
  final $Res Function(_Label) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mailboxId = null,Object? name = null,Object? color = freezed,Object? createdAt = freezed,}) {
  return _then(_Label(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
