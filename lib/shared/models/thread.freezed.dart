// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MailThread {

 String get id;@JsonKey(name: 'mailbox') String get mailboxId; String get subject; List<String> get participants; int get messageCount; bool get hasUnread; int get unreadCount; String? get snippet; String? get latestDirection; bool get hasAttachments; List<String> get attachmentFilenames; List<ThreadLabel> get labels; String? get searchHighlight; DateTime? get lastMessageAt; DateTime? get createdAt;
/// Create a copy of MailThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailThreadCopyWith<MailThread> get copyWith => _$MailThreadCopyWithImpl<MailThread>(this as MailThread, _$identity);

  /// Serializes this MailThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MailThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailThread&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.mailboxId, _this.mailboxId) || other.mailboxId == _this.mailboxId)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&const DeepCollectionEquality().equals(other.participants, _this.participants)&&(identical(other.messageCount, _this.messageCount) || other.messageCount == _this.messageCount)&&(identical(other.hasUnread, _this.hasUnread) || other.hasUnread == _this.hasUnread)&&(identical(other.unreadCount, _this.unreadCount) || other.unreadCount == _this.unreadCount)&&(identical(other.snippet, _this.snippet) || other.snippet == _this.snippet)&&(identical(other.latestDirection, _this.latestDirection) || other.latestDirection == _this.latestDirection)&&(identical(other.hasAttachments, _this.hasAttachments) || other.hasAttachments == _this.hasAttachments)&&const DeepCollectionEquality().equals(other.attachmentFilenames, _this.attachmentFilenames)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.searchHighlight, _this.searchHighlight) || other.searchHighlight == _this.searchHighlight)&&(identical(other.lastMessageAt, _this.lastMessageAt) || other.lastMessageAt == _this.lastMessageAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MailThread;
  return Object.hash(runtimeType,_this.id,_this.mailboxId,_this.subject,const DeepCollectionEquality().hash(_this.participants),_this.messageCount,_this.hasUnread,_this.unreadCount,_this.snippet,_this.latestDirection,_this.hasAttachments,const DeepCollectionEquality().hash(_this.attachmentFilenames),const DeepCollectionEquality().hash(_this.labels),_this.searchHighlight,_this.lastMessageAt,_this.createdAt);
}

@override
String toString() {
  final _this = this as MailThread;
  return 'MailThread(id: ${_this.id}, mailboxId: ${_this.mailboxId}, subject: ${_this.subject}, participants: ${_this.participants}, messageCount: ${_this.messageCount}, hasUnread: ${_this.hasUnread}, unreadCount: ${_this.unreadCount}, snippet: ${_this.snippet}, latestDirection: ${_this.latestDirection}, hasAttachments: ${_this.hasAttachments}, attachmentFilenames: ${_this.attachmentFilenames}, labels: ${_this.labels}, searchHighlight: ${_this.searchHighlight}, lastMessageAt: ${_this.lastMessageAt}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MailThreadCopyWith<$Res>  {
  factory $MailThreadCopyWith(MailThread value, $Res Function(MailThread) _then) = _$MailThreadCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'mailbox') String mailboxId, String subject, List<String> participants, int messageCount, bool hasUnread, int unreadCount, String? snippet, String? latestDirection, bool hasAttachments, List<String> attachmentFilenames, List<ThreadLabel> labels, String? searchHighlight, DateTime? lastMessageAt, DateTime? createdAt
});




}
/// @nodoc
class _$MailThreadCopyWithImpl<$Res>
    implements $MailThreadCopyWith<$Res> {
  _$MailThreadCopyWithImpl(this._self, this._then);

  final MailThread _self;
  final $Res Function(MailThread) _then;

/// Create a copy of MailThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mailboxId = null,Object? subject = null,Object? participants = null,Object? messageCount = null,Object? hasUnread = null,Object? unreadCount = null,Object? snippet = freezed,Object? latestDirection = freezed,Object? hasAttachments = null,Object? attachmentFilenames = null,Object? labels = null,Object? searchHighlight = freezed,Object? lastMessageAt = freezed,Object? createdAt = freezed,}) {
  return _then(MailThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,snippet: freezed == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String?,latestDirection: freezed == latestDirection ? _self.latestDirection : latestDirection // ignore: cast_nullable_to_non_nullable
as String?,hasAttachments: null == hasAttachments ? _self.hasAttachments : hasAttachments // ignore: cast_nullable_to_non_nullable
as bool,attachmentFilenames: null == attachmentFilenames ? _self.attachmentFilenames : attachmentFilenames // ignore: cast_nullable_to_non_nullable
as List<String>,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<ThreadLabel>,searchHighlight: freezed == searchHighlight ? _self.searchHighlight : searchHighlight // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MailThread].
extension MailThreadPatterns on MailThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MailThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MailThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MailThread value)  $default,){
final _that = this;
switch (_that) {
case _MailThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MailThread value)?  $default,){
final _that = this;
switch (_that) {
case _MailThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mailbox')  String mailboxId,  String subject,  List<String> participants,  int messageCount,  bool hasUnread,  int unreadCount,  String? snippet,  String? latestDirection,  bool hasAttachments,  List<String> attachmentFilenames,  List<ThreadLabel> labels,  String? searchHighlight,  DateTime? lastMessageAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MailThread() when $default != null:
return $default(_that.id,_that.mailboxId,_that.subject,_that.participants,_that.messageCount,_that.hasUnread,_that.unreadCount,_that.snippet,_that.latestDirection,_that.hasAttachments,_that.attachmentFilenames,_that.labels,_that.searchHighlight,_that.lastMessageAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mailbox')  String mailboxId,  String subject,  List<String> participants,  int messageCount,  bool hasUnread,  int unreadCount,  String? snippet,  String? latestDirection,  bool hasAttachments,  List<String> attachmentFilenames,  List<ThreadLabel> labels,  String? searchHighlight,  DateTime? lastMessageAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MailThread():
return $default(_that.id,_that.mailboxId,_that.subject,_that.participants,_that.messageCount,_that.hasUnread,_that.unreadCount,_that.snippet,_that.latestDirection,_that.hasAttachments,_that.attachmentFilenames,_that.labels,_that.searchHighlight,_that.lastMessageAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'mailbox')  String mailboxId,  String subject,  List<String> participants,  int messageCount,  bool hasUnread,  int unreadCount,  String? snippet,  String? latestDirection,  bool hasAttachments,  List<String> attachmentFilenames,  List<ThreadLabel> labels,  String? searchHighlight,  DateTime? lastMessageAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MailThread() when $default != null:
return $default(_that.id,_that.mailboxId,_that.subject,_that.participants,_that.messageCount,_that.hasUnread,_that.unreadCount,_that.snippet,_that.latestDirection,_that.hasAttachments,_that.attachmentFilenames,_that.labels,_that.searchHighlight,_that.lastMessageAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MailThread implements MailThread {
  const _MailThread({required this.id, @JsonKey(name: 'mailbox') required this.mailboxId, required this.subject,  List<String> participants = const [], this.messageCount = 0, this.hasUnread = false, this.unreadCount = 0, this.snippet, this.latestDirection, this.hasAttachments = false,  List<String> attachmentFilenames = const [],  List<ThreadLabel> labels = const [], this.searchHighlight, this.lastMessageAt, this.createdAt}): _participants = participants,_attachmentFilenames = attachmentFilenames,_labels = labels;
  factory _MailThread.fromJson(Map<String, dynamic> json) => _$MailThreadFromJson(json);

@override final  String id;
@override@JsonKey(name: 'mailbox') final  String mailboxId;
@override final  String subject;
 final  List<String> _participants;
@override@JsonKey() List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override@JsonKey() final  int messageCount;
@override@JsonKey() final  bool hasUnread;
@override@JsonKey() final  int unreadCount;
@override final  String? snippet;
@override final  String? latestDirection;
@override@JsonKey() final  bool hasAttachments;
 final  List<String> _attachmentFilenames;
@override@JsonKey() List<String> get attachmentFilenames {
  if (_attachmentFilenames is EqualUnmodifiableListView) return _attachmentFilenames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachmentFilenames);
}

 final  List<ThreadLabel> _labels;
@override@JsonKey() List<ThreadLabel> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  String? searchHighlight;
@override final  DateTime? lastMessageAt;
@override final  DateTime? createdAt;

/// Create a copy of MailThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailThreadCopyWith<_MailThread> get copyWith => __$MailThreadCopyWithImpl<_MailThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MailThreadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MailThread&&(identical(other.id, id) || other.id == id)&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.subject, subject) || other.subject == subject)&&const DeepCollectionEquality().equals(other.participants, _participants)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount)&&(identical(other.hasUnread, hasUnread) || other.hasUnread == hasUnread)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.latestDirection, latestDirection) || other.latestDirection == latestDirection)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&const DeepCollectionEquality().equals(other.attachmentFilenames, _attachmentFilenames)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.searchHighlight, searchHighlight) || other.searchHighlight == searchHighlight)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,mailboxId,subject,const DeepCollectionEquality().hash(_participants),messageCount,hasUnread,unreadCount,snippet,latestDirection,hasAttachments,const DeepCollectionEquality().hash(_attachmentFilenames),const DeepCollectionEquality().hash(_labels),searchHighlight,lastMessageAt,createdAt);
}

@override
String toString() {
    return 'MailThread(id: $id, mailboxId: $mailboxId, subject: $subject, participants: $participants, messageCount: $messageCount, hasUnread: $hasUnread, unreadCount: $unreadCount, snippet: $snippet, latestDirection: $latestDirection, hasAttachments: $hasAttachments, attachmentFilenames: $attachmentFilenames, labels: $labels, searchHighlight: $searchHighlight, lastMessageAt: $lastMessageAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MailThreadCopyWith<$Res> implements $MailThreadCopyWith<$Res> {
  factory _$MailThreadCopyWith(_MailThread value, $Res Function(_MailThread) _then) = __$MailThreadCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'mailbox') String mailboxId, String subject, List<String> participants, int messageCount, bool hasUnread, int unreadCount, String? snippet, String? latestDirection, bool hasAttachments, List<String> attachmentFilenames, List<ThreadLabel> labels, String? searchHighlight, DateTime? lastMessageAt, DateTime? createdAt
});




}
/// @nodoc
class __$MailThreadCopyWithImpl<$Res>
    implements _$MailThreadCopyWith<$Res> {
  __$MailThreadCopyWithImpl(this._self, this._then);

  final _MailThread _self;
  final $Res Function(_MailThread) _then;

/// Create a copy of MailThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mailboxId = null,Object? subject = null,Object? participants = null,Object? messageCount = null,Object? hasUnread = null,Object? unreadCount = null,Object? snippet = freezed,Object? latestDirection = freezed,Object? hasAttachments = null,Object? attachmentFilenames = null,Object? labels = null,Object? searchHighlight = freezed,Object? lastMessageAt = freezed,Object? createdAt = freezed,}) {
  return _then(_MailThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,snippet: freezed == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String?,latestDirection: freezed == latestDirection ? _self.latestDirection : latestDirection // ignore: cast_nullable_to_non_nullable
as String?,hasAttachments: null == hasAttachments ? _self.hasAttachments : hasAttachments // ignore: cast_nullable_to_non_nullable
as bool,attachmentFilenames: null == attachmentFilenames ? _self._attachmentFilenames : attachmentFilenames // ignore: cast_nullable_to_non_nullable
as List<String>,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<ThreadLabel>,searchHighlight: freezed == searchHighlight ? _self.searchHighlight : searchHighlight // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ThreadLabel {

 String get id; String get name; String? get color;
/// Create a copy of ThreadLabel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThreadLabelCopyWith<ThreadLabel> get copyWith => _$ThreadLabelCopyWithImpl<ThreadLabel>(this as ThreadLabel, _$identity);

  /// Serializes this ThreadLabel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ThreadLabel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThreadLabel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ThreadLabel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.color);
}

@override
String toString() {
  final _this = this as ThreadLabel;
  return 'ThreadLabel(id: ${_this.id}, name: ${_this.name}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $ThreadLabelCopyWith<$Res>  {
  factory $ThreadLabelCopyWith(ThreadLabel value, $Res Function(ThreadLabel) _then) = _$ThreadLabelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? color
});




}
/// @nodoc
class _$ThreadLabelCopyWithImpl<$Res>
    implements $ThreadLabelCopyWith<$Res> {
  _$ThreadLabelCopyWithImpl(this._self, this._then);

  final ThreadLabel _self;
  final $Res Function(ThreadLabel) _then;

/// Create a copy of ThreadLabel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = freezed,}) {
  return _then(ThreadLabel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ThreadLabel].
extension ThreadLabelPatterns on ThreadLabel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThreadLabel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThreadLabel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThreadLabel value)  $default,){
final _that = this;
switch (_that) {
case _ThreadLabel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThreadLabel value)?  $default,){
final _that = this;
switch (_that) {
case _ThreadLabel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThreadLabel() when $default != null:
return $default(_that.id,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? color)  $default,) {final _that = this;
switch (_that) {
case _ThreadLabel():
return $default(_that.id,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _ThreadLabel() when $default != null:
return $default(_that.id,_that.name,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThreadLabel implements ThreadLabel {
  const _ThreadLabel({required this.id, required this.name, this.color});
  factory _ThreadLabel.fromJson(Map<String, dynamic> json) => _$ThreadLabelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? color;

/// Create a copy of ThreadLabel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThreadLabelCopyWith<_ThreadLabel> get copyWith => __$ThreadLabelCopyWithImpl<_ThreadLabel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThreadLabelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThreadLabel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,color);
}

@override
String toString() {
    return 'ThreadLabel(id: $id, name: $name, color: $color)';
}


}

/// @nodoc
abstract mixin class _$ThreadLabelCopyWith<$Res> implements $ThreadLabelCopyWith<$Res> {
  factory _$ThreadLabelCopyWith(_ThreadLabel value, $Res Function(_ThreadLabel) _then) = __$ThreadLabelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? color
});




}
/// @nodoc
class __$ThreadLabelCopyWithImpl<$Res>
    implements _$ThreadLabelCopyWith<$Res> {
  __$ThreadLabelCopyWithImpl(this._self, this._then);

  final _ThreadLabel _self;
  final $Res Function(_ThreadLabel) _then;

/// Create a copy of ThreadLabel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = freezed,}) {
  return _then(_ThreadLabel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
