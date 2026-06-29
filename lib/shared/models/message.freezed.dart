// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmailAddress {

 String get email; String get name;
/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailAddressCopyWith<EmailAddress> get copyWith => _$EmailAddressCopyWithImpl<EmailAddress>(this as EmailAddress, _$identity);

  /// Serializes this EmailAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAddress&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,name);

@override
String toString() {
  return 'EmailAddress(email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class $EmailAddressCopyWith<$Res>  {
  factory $EmailAddressCopyWith(EmailAddress value, $Res Function(EmailAddress) _then) = _$EmailAddressCopyWithImpl;
@useResult
$Res call({
 String email, String name
});




}
/// @nodoc
class _$EmailAddressCopyWithImpl<$Res>
    implements $EmailAddressCopyWith<$Res> {
  _$EmailAddressCopyWithImpl(this._self, this._then);

  final EmailAddress _self;
  final $Res Function(EmailAddress) _then;

/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? name = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailAddress].
extension EmailAddressPatterns on EmailAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailAddress value)  $default,){
final _that = this;
switch (_that) {
case _EmailAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailAddress value)?  $default,){
final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
return $default(_that.email,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String name)  $default,) {final _that = this;
switch (_that) {
case _EmailAddress():
return $default(_that.email,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String name)?  $default,) {final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
return $default(_that.email,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailAddress implements EmailAddress {
  const _EmailAddress({required this.email, this.name = ''});
  factory _EmailAddress.fromJson(Map<String, dynamic> json) => _$EmailAddressFromJson(json);

@override final  String email;
@override@JsonKey() final  String name;

/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailAddressCopyWith<_EmailAddress> get copyWith => __$EmailAddressCopyWithImpl<_EmailAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailAddress&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,name);

@override
String toString() {
  return 'EmailAddress(email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class _$EmailAddressCopyWith<$Res> implements $EmailAddressCopyWith<$Res> {
  factory _$EmailAddressCopyWith(_EmailAddress value, $Res Function(_EmailAddress) _then) = __$EmailAddressCopyWithImpl;
@override @useResult
$Res call({
 String email, String name
});




}
/// @nodoc
class __$EmailAddressCopyWithImpl<$Res>
    implements _$EmailAddressCopyWith<$Res> {
  __$EmailAddressCopyWithImpl(this._self, this._then);

  final _EmailAddress _self;
  final $Res Function(_EmailAddress) _then;

/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? name = null,}) {
  return _then(_EmailAddress(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Attachment {

 String get id; String get filename; String get contentType; int get sizeBytes; String? get file; bool get isInline; String? get contentId;
/// Create a copy of Attachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachmentCopyWith<Attachment> get copyWith => _$AttachmentCopyWithImpl<Attachment>(this as Attachment, _$identity);

  /// Serializes this Attachment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Attachment&&(identical(other.id, id) || other.id == id)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.file, file) || other.file == file)&&(identical(other.isInline, isInline) || other.isInline == isInline)&&(identical(other.contentId, contentId) || other.contentId == contentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filename,contentType,sizeBytes,file,isInline,contentId);

@override
String toString() {
  return 'Attachment(id: $id, filename: $filename, contentType: $contentType, sizeBytes: $sizeBytes, file: $file, isInline: $isInline, contentId: $contentId)';
}


}

/// @nodoc
abstract mixin class $AttachmentCopyWith<$Res>  {
  factory $AttachmentCopyWith(Attachment value, $Res Function(Attachment) _then) = _$AttachmentCopyWithImpl;
@useResult
$Res call({
 String id, String filename, String contentType, int sizeBytes, String? file, bool isInline, String? contentId
});




}
/// @nodoc
class _$AttachmentCopyWithImpl<$Res>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._self, this._then);

  final Attachment _self;
  final $Res Function(Attachment) _then;

/// Create a copy of Attachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? filename = null,Object? contentType = null,Object? sizeBytes = null,Object? file = freezed,Object? isInline = null,Object? contentId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,file: freezed == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String?,isInline: null == isInline ? _self.isInline : isInline // ignore: cast_nullable_to_non_nullable
as bool,contentId: freezed == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Attachment].
extension AttachmentPatterns on Attachment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Attachment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attachment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Attachment value)  $default,){
final _that = this;
switch (_that) {
case _Attachment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Attachment value)?  $default,){
final _that = this;
switch (_that) {
case _Attachment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String filename,  String contentType,  int sizeBytes,  String? file,  bool isInline,  String? contentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attachment() when $default != null:
return $default(_that.id,_that.filename,_that.contentType,_that.sizeBytes,_that.file,_that.isInline,_that.contentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String filename,  String contentType,  int sizeBytes,  String? file,  bool isInline,  String? contentId)  $default,) {final _that = this;
switch (_that) {
case _Attachment():
return $default(_that.id,_that.filename,_that.contentType,_that.sizeBytes,_that.file,_that.isInline,_that.contentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String filename,  String contentType,  int sizeBytes,  String? file,  bool isInline,  String? contentId)?  $default,) {final _that = this;
switch (_that) {
case _Attachment() when $default != null:
return $default(_that.id,_that.filename,_that.contentType,_that.sizeBytes,_that.file,_that.isInline,_that.contentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Attachment implements Attachment {
  const _Attachment({required this.id, required this.filename, required this.contentType, this.sizeBytes = 0, this.file, this.isInline = false, this.contentId});
  factory _Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);

@override final  String id;
@override final  String filename;
@override final  String contentType;
@override@JsonKey() final  int sizeBytes;
@override final  String? file;
@override@JsonKey() final  bool isInline;
@override final  String? contentId;

/// Create a copy of Attachment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentCopyWith<_Attachment> get copyWith => __$AttachmentCopyWithImpl<_Attachment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttachmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attachment&&(identical(other.id, id) || other.id == id)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.file, file) || other.file == file)&&(identical(other.isInline, isInline) || other.isInline == isInline)&&(identical(other.contentId, contentId) || other.contentId == contentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filename,contentType,sizeBytes,file,isInline,contentId);

@override
String toString() {
  return 'Attachment(id: $id, filename: $filename, contentType: $contentType, sizeBytes: $sizeBytes, file: $file, isInline: $isInline, contentId: $contentId)';
}


}

/// @nodoc
abstract mixin class _$AttachmentCopyWith<$Res> implements $AttachmentCopyWith<$Res> {
  factory _$AttachmentCopyWith(_Attachment value, $Res Function(_Attachment) _then) = __$AttachmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String filename, String contentType, int sizeBytes, String? file, bool isInline, String? contentId
});




}
/// @nodoc
class __$AttachmentCopyWithImpl<$Res>
    implements _$AttachmentCopyWith<$Res> {
  __$AttachmentCopyWithImpl(this._self, this._then);

  final _Attachment _self;
  final $Res Function(_Attachment) _then;

/// Create a copy of Attachment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? filename = null,Object? contentType = null,Object? sizeBytes = null,Object? file = freezed,Object? isInline = null,Object? contentId = freezed,}) {
  return _then(_Attachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,file: freezed == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String?,isInline: null == isInline ? _self.isInline : isInline // ignore: cast_nullable_to_non_nullable
as bool,contentId: freezed == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MailMessage {

 String get id;@JsonKey(name: 'mailbox') String get mailboxId;@JsonKey(name: 'thread') String? get threadId; String get direction; String get status; String get folder; String get fromAddress; String? get fromName; String? get envelopeSender; String? get envelopeRecipient; List<EmailAddress> get toAddresses; List<EmailAddress> get ccAddresses; List<EmailAddress> get bccAddresses; String? get replyTo; String get subject; String? get snippet; String? get bodyText; String? get bodyHtml; String? get rawMimeUrl; bool get isRead; bool get isStarred; bool get hasAttachments; List<Attachment> get attachments; Map<String, dynamic> get rawHeaders; Map<String, dynamic> get metadata; DateTime? get receivedAt; DateTime? get sentAt; DateTime? get scheduledAt; DateTime? get createdAt;
/// Create a copy of MailMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MailMessageCopyWith<MailMessage> get copyWith => _$MailMessageCopyWithImpl<MailMessage>(this as MailMessage, _$identity);

  /// Serializes this MailMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MailMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.fromAddress, fromAddress) || other.fromAddress == fromAddress)&&(identical(other.fromName, fromName) || other.fromName == fromName)&&(identical(other.envelopeSender, envelopeSender) || other.envelopeSender == envelopeSender)&&(identical(other.envelopeRecipient, envelopeRecipient) || other.envelopeRecipient == envelopeRecipient)&&const DeepCollectionEquality().equals(other.toAddresses, toAddresses)&&const DeepCollectionEquality().equals(other.ccAddresses, ccAddresses)&&const DeepCollectionEquality().equals(other.bccAddresses, bccAddresses)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.rawMimeUrl, rawMimeUrl) || other.rawMimeUrl == rawMimeUrl)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.isStarred, isStarred) || other.isStarred == isStarred)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&const DeepCollectionEquality().equals(other.attachments, attachments)&&const DeepCollectionEquality().equals(other.rawHeaders, rawHeaders)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,mailboxId,threadId,direction,status,folder,fromAddress,fromName,envelopeSender,envelopeRecipient,const DeepCollectionEquality().hash(toAddresses),const DeepCollectionEquality().hash(ccAddresses),const DeepCollectionEquality().hash(bccAddresses),replyTo,subject,snippet,bodyText,bodyHtml,rawMimeUrl,isRead,isStarred,hasAttachments,const DeepCollectionEquality().hash(attachments),const DeepCollectionEquality().hash(rawHeaders),const DeepCollectionEquality().hash(metadata),receivedAt,sentAt,scheduledAt,createdAt]);

@override
String toString() {
  return 'MailMessage(id: $id, mailboxId: $mailboxId, threadId: $threadId, direction: $direction, status: $status, folder: $folder, fromAddress: $fromAddress, fromName: $fromName, envelopeSender: $envelopeSender, envelopeRecipient: $envelopeRecipient, toAddresses: $toAddresses, ccAddresses: $ccAddresses, bccAddresses: $bccAddresses, replyTo: $replyTo, subject: $subject, snippet: $snippet, bodyText: $bodyText, bodyHtml: $bodyHtml, rawMimeUrl: $rawMimeUrl, isRead: $isRead, isStarred: $isStarred, hasAttachments: $hasAttachments, attachments: $attachments, rawHeaders: $rawHeaders, metadata: $metadata, receivedAt: $receivedAt, sentAt: $sentAt, scheduledAt: $scheduledAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MailMessageCopyWith<$Res>  {
  factory $MailMessageCopyWith(MailMessage value, $Res Function(MailMessage) _then) = _$MailMessageCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'mailbox') String mailboxId,@JsonKey(name: 'thread') String? threadId, String direction, String status, String folder, String fromAddress, String? fromName, String? envelopeSender, String? envelopeRecipient, List<EmailAddress> toAddresses, List<EmailAddress> ccAddresses, List<EmailAddress> bccAddresses, String? replyTo, String subject, String? snippet, String? bodyText, String? bodyHtml, String? rawMimeUrl, bool isRead, bool isStarred, bool hasAttachments, List<Attachment> attachments, Map<String, dynamic> rawHeaders, Map<String, dynamic> metadata, DateTime? receivedAt, DateTime? sentAt, DateTime? scheduledAt, DateTime? createdAt
});




}
/// @nodoc
class _$MailMessageCopyWithImpl<$Res>
    implements $MailMessageCopyWith<$Res> {
  _$MailMessageCopyWithImpl(this._self, this._then);

  final MailMessage _self;
  final $Res Function(MailMessage) _then;

/// Create a copy of MailMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mailboxId = null,Object? threadId = freezed,Object? direction = null,Object? status = null,Object? folder = null,Object? fromAddress = null,Object? fromName = freezed,Object? envelopeSender = freezed,Object? envelopeRecipient = freezed,Object? toAddresses = null,Object? ccAddresses = null,Object? bccAddresses = null,Object? replyTo = freezed,Object? subject = null,Object? snippet = freezed,Object? bodyText = freezed,Object? bodyHtml = freezed,Object? rawMimeUrl = freezed,Object? isRead = null,Object? isStarred = null,Object? hasAttachments = null,Object? attachments = null,Object? rawHeaders = null,Object? metadata = null,Object? receivedAt = freezed,Object? sentAt = freezed,Object? scheduledAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,fromAddress: null == fromAddress ? _self.fromAddress : fromAddress // ignore: cast_nullable_to_non_nullable
as String,fromName: freezed == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String?,envelopeSender: freezed == envelopeSender ? _self.envelopeSender : envelopeSender // ignore: cast_nullable_to_non_nullable
as String?,envelopeRecipient: freezed == envelopeRecipient ? _self.envelopeRecipient : envelopeRecipient // ignore: cast_nullable_to_non_nullable
as String?,toAddresses: null == toAddresses ? _self.toAddresses : toAddresses // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,ccAddresses: null == ccAddresses ? _self.ccAddresses : ccAddresses // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,bccAddresses: null == bccAddresses ? _self.bccAddresses : bccAddresses // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,snippet: freezed == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String?,bodyText: freezed == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String?,bodyHtml: freezed == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String?,rawMimeUrl: freezed == rawMimeUrl ? _self.rawMimeUrl : rawMimeUrl // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,isStarred: null == isStarred ? _self.isStarred : isStarred // ignore: cast_nullable_to_non_nullable
as bool,hasAttachments: null == hasAttachments ? _self.hasAttachments : hasAttachments // ignore: cast_nullable_to_non_nullable
as bool,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<Attachment>,rawHeaders: null == rawHeaders ? _self.rawHeaders : rawHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MailMessage].
extension MailMessagePatterns on MailMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MailMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MailMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MailMessage value)  $default,){
final _that = this;
switch (_that) {
case _MailMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MailMessage value)?  $default,){
final _that = this;
switch (_that) {
case _MailMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mailbox')  String mailboxId, @JsonKey(name: 'thread')  String? threadId,  String direction,  String status,  String folder,  String fromAddress,  String? fromName,  String? envelopeSender,  String? envelopeRecipient,  List<EmailAddress> toAddresses,  List<EmailAddress> ccAddresses,  List<EmailAddress> bccAddresses,  String? replyTo,  String subject,  String? snippet,  String? bodyText,  String? bodyHtml,  String? rawMimeUrl,  bool isRead,  bool isStarred,  bool hasAttachments,  List<Attachment> attachments,  Map<String, dynamic> rawHeaders,  Map<String, dynamic> metadata,  DateTime? receivedAt,  DateTime? sentAt,  DateTime? scheduledAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MailMessage() when $default != null:
return $default(_that.id,_that.mailboxId,_that.threadId,_that.direction,_that.status,_that.folder,_that.fromAddress,_that.fromName,_that.envelopeSender,_that.envelopeRecipient,_that.toAddresses,_that.ccAddresses,_that.bccAddresses,_that.replyTo,_that.subject,_that.snippet,_that.bodyText,_that.bodyHtml,_that.rawMimeUrl,_that.isRead,_that.isStarred,_that.hasAttachments,_that.attachments,_that.rawHeaders,_that.metadata,_that.receivedAt,_that.sentAt,_that.scheduledAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'mailbox')  String mailboxId, @JsonKey(name: 'thread')  String? threadId,  String direction,  String status,  String folder,  String fromAddress,  String? fromName,  String? envelopeSender,  String? envelopeRecipient,  List<EmailAddress> toAddresses,  List<EmailAddress> ccAddresses,  List<EmailAddress> bccAddresses,  String? replyTo,  String subject,  String? snippet,  String? bodyText,  String? bodyHtml,  String? rawMimeUrl,  bool isRead,  bool isStarred,  bool hasAttachments,  List<Attachment> attachments,  Map<String, dynamic> rawHeaders,  Map<String, dynamic> metadata,  DateTime? receivedAt,  DateTime? sentAt,  DateTime? scheduledAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MailMessage():
return $default(_that.id,_that.mailboxId,_that.threadId,_that.direction,_that.status,_that.folder,_that.fromAddress,_that.fromName,_that.envelopeSender,_that.envelopeRecipient,_that.toAddresses,_that.ccAddresses,_that.bccAddresses,_that.replyTo,_that.subject,_that.snippet,_that.bodyText,_that.bodyHtml,_that.rawMimeUrl,_that.isRead,_that.isStarred,_that.hasAttachments,_that.attachments,_that.rawHeaders,_that.metadata,_that.receivedAt,_that.sentAt,_that.scheduledAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'mailbox')  String mailboxId, @JsonKey(name: 'thread')  String? threadId,  String direction,  String status,  String folder,  String fromAddress,  String? fromName,  String? envelopeSender,  String? envelopeRecipient,  List<EmailAddress> toAddresses,  List<EmailAddress> ccAddresses,  List<EmailAddress> bccAddresses,  String? replyTo,  String subject,  String? snippet,  String? bodyText,  String? bodyHtml,  String? rawMimeUrl,  bool isRead,  bool isStarred,  bool hasAttachments,  List<Attachment> attachments,  Map<String, dynamic> rawHeaders,  Map<String, dynamic> metadata,  DateTime? receivedAt,  DateTime? sentAt,  DateTime? scheduledAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MailMessage() when $default != null:
return $default(_that.id,_that.mailboxId,_that.threadId,_that.direction,_that.status,_that.folder,_that.fromAddress,_that.fromName,_that.envelopeSender,_that.envelopeRecipient,_that.toAddresses,_that.ccAddresses,_that.bccAddresses,_that.replyTo,_that.subject,_that.snippet,_that.bodyText,_that.bodyHtml,_that.rawMimeUrl,_that.isRead,_that.isStarred,_that.hasAttachments,_that.attachments,_that.rawHeaders,_that.metadata,_that.receivedAt,_that.sentAt,_that.scheduledAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MailMessage implements MailMessage {
  const _MailMessage({required this.id, @JsonKey(name: 'mailbox') required this.mailboxId, @JsonKey(name: 'thread') this.threadId, required this.direction, required this.status, this.folder = 'inbox', required this.fromAddress, this.fromName, this.envelopeSender, this.envelopeRecipient, final  List<EmailAddress> toAddresses = const [], final  List<EmailAddress> ccAddresses = const [], final  List<EmailAddress> bccAddresses = const [], this.replyTo, required this.subject, this.snippet, this.bodyText, this.bodyHtml, this.rawMimeUrl, this.isRead = false, this.isStarred = false, this.hasAttachments = false, final  List<Attachment> attachments = const [], final  Map<String, dynamic> rawHeaders = const {}, final  Map<String, dynamic> metadata = const {}, this.receivedAt, this.sentAt, this.scheduledAt, this.createdAt}): _toAddresses = toAddresses,_ccAddresses = ccAddresses,_bccAddresses = bccAddresses,_attachments = attachments,_rawHeaders = rawHeaders,_metadata = metadata;
  factory _MailMessage.fromJson(Map<String, dynamic> json) => _$MailMessageFromJson(json);

@override final  String id;
@override@JsonKey(name: 'mailbox') final  String mailboxId;
@override@JsonKey(name: 'thread') final  String? threadId;
@override final  String direction;
@override final  String status;
@override@JsonKey() final  String folder;
@override final  String fromAddress;
@override final  String? fromName;
@override final  String? envelopeSender;
@override final  String? envelopeRecipient;
 final  List<EmailAddress> _toAddresses;
@override@JsonKey() List<EmailAddress> get toAddresses {
  if (_toAddresses is EqualUnmodifiableListView) return _toAddresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toAddresses);
}

 final  List<EmailAddress> _ccAddresses;
@override@JsonKey() List<EmailAddress> get ccAddresses {
  if (_ccAddresses is EqualUnmodifiableListView) return _ccAddresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ccAddresses);
}

 final  List<EmailAddress> _bccAddresses;
@override@JsonKey() List<EmailAddress> get bccAddresses {
  if (_bccAddresses is EqualUnmodifiableListView) return _bccAddresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bccAddresses);
}

@override final  String? replyTo;
@override final  String subject;
@override final  String? snippet;
@override final  String? bodyText;
@override final  String? bodyHtml;
@override final  String? rawMimeUrl;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool isStarred;
@override@JsonKey() final  bool hasAttachments;
 final  List<Attachment> _attachments;
@override@JsonKey() List<Attachment> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

 final  Map<String, dynamic> _rawHeaders;
@override@JsonKey() Map<String, dynamic> get rawHeaders {
  if (_rawHeaders is EqualUnmodifiableMapView) return _rawHeaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rawHeaders);
}

 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override final  DateTime? receivedAt;
@override final  DateTime? sentAt;
@override final  DateTime? scheduledAt;
@override final  DateTime? createdAt;

/// Create a copy of MailMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MailMessageCopyWith<_MailMessage> get copyWith => __$MailMessageCopyWithImpl<_MailMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MailMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MailMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.fromAddress, fromAddress) || other.fromAddress == fromAddress)&&(identical(other.fromName, fromName) || other.fromName == fromName)&&(identical(other.envelopeSender, envelopeSender) || other.envelopeSender == envelopeSender)&&(identical(other.envelopeRecipient, envelopeRecipient) || other.envelopeRecipient == envelopeRecipient)&&const DeepCollectionEquality().equals(other._toAddresses, _toAddresses)&&const DeepCollectionEquality().equals(other._ccAddresses, _ccAddresses)&&const DeepCollectionEquality().equals(other._bccAddresses, _bccAddresses)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.rawMimeUrl, rawMimeUrl) || other.rawMimeUrl == rawMimeUrl)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.isStarred, isStarred) || other.isStarred == isStarred)&&(identical(other.hasAttachments, hasAttachments) || other.hasAttachments == hasAttachments)&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&const DeepCollectionEquality().equals(other._rawHeaders, _rawHeaders)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,mailboxId,threadId,direction,status,folder,fromAddress,fromName,envelopeSender,envelopeRecipient,const DeepCollectionEquality().hash(_toAddresses),const DeepCollectionEquality().hash(_ccAddresses),const DeepCollectionEquality().hash(_bccAddresses),replyTo,subject,snippet,bodyText,bodyHtml,rawMimeUrl,isRead,isStarred,hasAttachments,const DeepCollectionEquality().hash(_attachments),const DeepCollectionEquality().hash(_rawHeaders),const DeepCollectionEquality().hash(_metadata),receivedAt,sentAt,scheduledAt,createdAt]);

@override
String toString() {
  return 'MailMessage(id: $id, mailboxId: $mailboxId, threadId: $threadId, direction: $direction, status: $status, folder: $folder, fromAddress: $fromAddress, fromName: $fromName, envelopeSender: $envelopeSender, envelopeRecipient: $envelopeRecipient, toAddresses: $toAddresses, ccAddresses: $ccAddresses, bccAddresses: $bccAddresses, replyTo: $replyTo, subject: $subject, snippet: $snippet, bodyText: $bodyText, bodyHtml: $bodyHtml, rawMimeUrl: $rawMimeUrl, isRead: $isRead, isStarred: $isStarred, hasAttachments: $hasAttachments, attachments: $attachments, rawHeaders: $rawHeaders, metadata: $metadata, receivedAt: $receivedAt, sentAt: $sentAt, scheduledAt: $scheduledAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MailMessageCopyWith<$Res> implements $MailMessageCopyWith<$Res> {
  factory _$MailMessageCopyWith(_MailMessage value, $Res Function(_MailMessage) _then) = __$MailMessageCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'mailbox') String mailboxId,@JsonKey(name: 'thread') String? threadId, String direction, String status, String folder, String fromAddress, String? fromName, String? envelopeSender, String? envelopeRecipient, List<EmailAddress> toAddresses, List<EmailAddress> ccAddresses, List<EmailAddress> bccAddresses, String? replyTo, String subject, String? snippet, String? bodyText, String? bodyHtml, String? rawMimeUrl, bool isRead, bool isStarred, bool hasAttachments, List<Attachment> attachments, Map<String, dynamic> rawHeaders, Map<String, dynamic> metadata, DateTime? receivedAt, DateTime? sentAt, DateTime? scheduledAt, DateTime? createdAt
});




}
/// @nodoc
class __$MailMessageCopyWithImpl<$Res>
    implements _$MailMessageCopyWith<$Res> {
  __$MailMessageCopyWithImpl(this._self, this._then);

  final _MailMessage _self;
  final $Res Function(_MailMessage) _then;

/// Create a copy of MailMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mailboxId = null,Object? threadId = freezed,Object? direction = null,Object? status = null,Object? folder = null,Object? fromAddress = null,Object? fromName = freezed,Object? envelopeSender = freezed,Object? envelopeRecipient = freezed,Object? toAddresses = null,Object? ccAddresses = null,Object? bccAddresses = null,Object? replyTo = freezed,Object? subject = null,Object? snippet = freezed,Object? bodyText = freezed,Object? bodyHtml = freezed,Object? rawMimeUrl = freezed,Object? isRead = null,Object? isStarred = null,Object? hasAttachments = null,Object? attachments = null,Object? rawHeaders = null,Object? metadata = null,Object? receivedAt = freezed,Object? sentAt = freezed,Object? scheduledAt = freezed,Object? createdAt = freezed,}) {
  return _then(_MailMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as String,fromAddress: null == fromAddress ? _self.fromAddress : fromAddress // ignore: cast_nullable_to_non_nullable
as String,fromName: freezed == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String?,envelopeSender: freezed == envelopeSender ? _self.envelopeSender : envelopeSender // ignore: cast_nullable_to_non_nullable
as String?,envelopeRecipient: freezed == envelopeRecipient ? _self.envelopeRecipient : envelopeRecipient // ignore: cast_nullable_to_non_nullable
as String?,toAddresses: null == toAddresses ? _self._toAddresses : toAddresses // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,ccAddresses: null == ccAddresses ? _self._ccAddresses : ccAddresses // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,bccAddresses: null == bccAddresses ? _self._bccAddresses : bccAddresses // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,snippet: freezed == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String?,bodyText: freezed == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String?,bodyHtml: freezed == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String?,rawMimeUrl: freezed == rawMimeUrl ? _self.rawMimeUrl : rawMimeUrl // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,isStarred: null == isStarred ? _self.isStarred : isStarred // ignore: cast_nullable_to_non_nullable
as bool,hasAttachments: null == hasAttachments ? _self.hasAttachments : hasAttachments // ignore: cast_nullable_to_non_nullable
as bool,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<Attachment>,rawHeaders: null == rawHeaders ? _self._rawHeaders : rawHeaders // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SendMessageRequest {

 String get mailboxId; String? get senderIdentityId; List<EmailAddress> get to; List<EmailAddress> get cc; List<EmailAddress> get bcc; String get subject; String? get bodyText; String? get bodyHtml; String? get replyToMessageId; DateTime? get scheduledAt;
/// Create a copy of SendMessageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageRequestCopyWith<SendMessageRequest> get copyWith => _$SendMessageRequestCopyWithImpl<SendMessageRequest>(this as SendMessageRequest, _$identity);

  /// Serializes this SendMessageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageRequest&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.senderIdentityId, senderIdentityId) || other.senderIdentityId == senderIdentityId)&&const DeepCollectionEquality().equals(other.to, to)&&const DeepCollectionEquality().equals(other.cc, cc)&&const DeepCollectionEquality().equals(other.bcc, bcc)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailboxId,senderIdentityId,const DeepCollectionEquality().hash(to),const DeepCollectionEquality().hash(cc),const DeepCollectionEquality().hash(bcc),subject,bodyText,bodyHtml,replyToMessageId,scheduledAt);

@override
String toString() {
  return 'SendMessageRequest(mailboxId: $mailboxId, senderIdentityId: $senderIdentityId, to: $to, cc: $cc, bcc: $bcc, subject: $subject, bodyText: $bodyText, bodyHtml: $bodyHtml, replyToMessageId: $replyToMessageId, scheduledAt: $scheduledAt)';
}


}

/// @nodoc
abstract mixin class $SendMessageRequestCopyWith<$Res>  {
  factory $SendMessageRequestCopyWith(SendMessageRequest value, $Res Function(SendMessageRequest) _then) = _$SendMessageRequestCopyWithImpl;
@useResult
$Res call({
 String mailboxId, String? senderIdentityId, List<EmailAddress> to, List<EmailAddress> cc, List<EmailAddress> bcc, String subject, String? bodyText, String? bodyHtml, String? replyToMessageId, DateTime? scheduledAt
});




}
/// @nodoc
class _$SendMessageRequestCopyWithImpl<$Res>
    implements $SendMessageRequestCopyWith<$Res> {
  _$SendMessageRequestCopyWithImpl(this._self, this._then);

  final SendMessageRequest _self;
  final $Res Function(SendMessageRequest) _then;

/// Create a copy of SendMessageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mailboxId = null,Object? senderIdentityId = freezed,Object? to = null,Object? cc = null,Object? bcc = null,Object? subject = null,Object? bodyText = freezed,Object? bodyHtml = freezed,Object? replyToMessageId = freezed,Object? scheduledAt = freezed,}) {
  return _then(_self.copyWith(
mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,senderIdentityId: freezed == senderIdentityId ? _self.senderIdentityId : senderIdentityId // ignore: cast_nullable_to_non_nullable
as String?,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,cc: null == cc ? _self.cc : cc // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,bcc: null == bcc ? _self.bcc : bcc // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,bodyText: freezed == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String?,bodyHtml: freezed == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendMessageRequest].
extension SendMessageRequestPatterns on SendMessageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendMessageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendMessageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendMessageRequest value)  $default,){
final _that = this;
switch (_that) {
case _SendMessageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendMessageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SendMessageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mailboxId,  String? senderIdentityId,  List<EmailAddress> to,  List<EmailAddress> cc,  List<EmailAddress> bcc,  String subject,  String? bodyText,  String? bodyHtml,  String? replyToMessageId,  DateTime? scheduledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendMessageRequest() when $default != null:
return $default(_that.mailboxId,_that.senderIdentityId,_that.to,_that.cc,_that.bcc,_that.subject,_that.bodyText,_that.bodyHtml,_that.replyToMessageId,_that.scheduledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mailboxId,  String? senderIdentityId,  List<EmailAddress> to,  List<EmailAddress> cc,  List<EmailAddress> bcc,  String subject,  String? bodyText,  String? bodyHtml,  String? replyToMessageId,  DateTime? scheduledAt)  $default,) {final _that = this;
switch (_that) {
case _SendMessageRequest():
return $default(_that.mailboxId,_that.senderIdentityId,_that.to,_that.cc,_that.bcc,_that.subject,_that.bodyText,_that.bodyHtml,_that.replyToMessageId,_that.scheduledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mailboxId,  String? senderIdentityId,  List<EmailAddress> to,  List<EmailAddress> cc,  List<EmailAddress> bcc,  String subject,  String? bodyText,  String? bodyHtml,  String? replyToMessageId,  DateTime? scheduledAt)?  $default,) {final _that = this;
switch (_that) {
case _SendMessageRequest() when $default != null:
return $default(_that.mailboxId,_that.senderIdentityId,_that.to,_that.cc,_that.bcc,_that.subject,_that.bodyText,_that.bodyHtml,_that.replyToMessageId,_that.scheduledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendMessageRequest implements SendMessageRequest {
  const _SendMessageRequest({required this.mailboxId, this.senderIdentityId, required final  List<EmailAddress> to, final  List<EmailAddress> cc = const [], final  List<EmailAddress> bcc = const [], required this.subject, this.bodyText, this.bodyHtml, this.replyToMessageId, this.scheduledAt}): _to = to,_cc = cc,_bcc = bcc;
  factory _SendMessageRequest.fromJson(Map<String, dynamic> json) => _$SendMessageRequestFromJson(json);

@override final  String mailboxId;
@override final  String? senderIdentityId;
 final  List<EmailAddress> _to;
@override List<EmailAddress> get to {
  if (_to is EqualUnmodifiableListView) return _to;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_to);
}

 final  List<EmailAddress> _cc;
@override@JsonKey() List<EmailAddress> get cc {
  if (_cc is EqualUnmodifiableListView) return _cc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cc);
}

 final  List<EmailAddress> _bcc;
@override@JsonKey() List<EmailAddress> get bcc {
  if (_bcc is EqualUnmodifiableListView) return _bcc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bcc);
}

@override final  String subject;
@override final  String? bodyText;
@override final  String? bodyHtml;
@override final  String? replyToMessageId;
@override final  DateTime? scheduledAt;

/// Create a copy of SendMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendMessageRequestCopyWith<_SendMessageRequest> get copyWith => __$SendMessageRequestCopyWithImpl<_SendMessageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMessageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendMessageRequest&&(identical(other.mailboxId, mailboxId) || other.mailboxId == mailboxId)&&(identical(other.senderIdentityId, senderIdentityId) || other.senderIdentityId == senderIdentityId)&&const DeepCollectionEquality().equals(other._to, _to)&&const DeepCollectionEquality().equals(other._cc, _cc)&&const DeepCollectionEquality().equals(other._bcc, _bcc)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText)&&(identical(other.bodyHtml, bodyHtml) || other.bodyHtml == bodyHtml)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mailboxId,senderIdentityId,const DeepCollectionEquality().hash(_to),const DeepCollectionEquality().hash(_cc),const DeepCollectionEquality().hash(_bcc),subject,bodyText,bodyHtml,replyToMessageId,scheduledAt);

@override
String toString() {
  return 'SendMessageRequest(mailboxId: $mailboxId, senderIdentityId: $senderIdentityId, to: $to, cc: $cc, bcc: $bcc, subject: $subject, bodyText: $bodyText, bodyHtml: $bodyHtml, replyToMessageId: $replyToMessageId, scheduledAt: $scheduledAt)';
}


}

/// @nodoc
abstract mixin class _$SendMessageRequestCopyWith<$Res> implements $SendMessageRequestCopyWith<$Res> {
  factory _$SendMessageRequestCopyWith(_SendMessageRequest value, $Res Function(_SendMessageRequest) _then) = __$SendMessageRequestCopyWithImpl;
@override @useResult
$Res call({
 String mailboxId, String? senderIdentityId, List<EmailAddress> to, List<EmailAddress> cc, List<EmailAddress> bcc, String subject, String? bodyText, String? bodyHtml, String? replyToMessageId, DateTime? scheduledAt
});




}
/// @nodoc
class __$SendMessageRequestCopyWithImpl<$Res>
    implements _$SendMessageRequestCopyWith<$Res> {
  __$SendMessageRequestCopyWithImpl(this._self, this._then);

  final _SendMessageRequest _self;
  final $Res Function(_SendMessageRequest) _then;

/// Create a copy of SendMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mailboxId = null,Object? senderIdentityId = freezed,Object? to = null,Object? cc = null,Object? bcc = null,Object? subject = null,Object? bodyText = freezed,Object? bodyHtml = freezed,Object? replyToMessageId = freezed,Object? scheduledAt = freezed,}) {
  return _then(_SendMessageRequest(
mailboxId: null == mailboxId ? _self.mailboxId : mailboxId // ignore: cast_nullable_to_non_nullable
as String,senderIdentityId: freezed == senderIdentityId ? _self.senderIdentityId : senderIdentityId // ignore: cast_nullable_to_non_nullable
as String?,to: null == to ? _self._to : to // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,cc: null == cc ? _self._cc : cc // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,bcc: null == bcc ? _self._bcc : bcc // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,bodyText: freezed == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String?,bodyHtml: freezed == bodyHtml ? _self.bodyHtml : bodyHtml // ignore: cast_nullable_to_non_nullable
as String?,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
