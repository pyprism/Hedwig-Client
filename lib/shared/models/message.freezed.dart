// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmailAddress _$EmailAddressFromJson(Map<String, dynamic> json) {
  return _EmailAddress.fromJson(json);
}

/// @nodoc
mixin _$EmailAddress {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this EmailAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailAddressCopyWith<EmailAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailAddressCopyWith<$Res> {
  factory $EmailAddressCopyWith(
    EmailAddress value,
    $Res Function(EmailAddress) then,
  ) = _$EmailAddressCopyWithImpl<$Res, EmailAddress>;
  @useResult
  $Res call({String email, String name});
}

/// @nodoc
class _$EmailAddressCopyWithImpl<$Res, $Val extends EmailAddress>
    implements $EmailAddressCopyWith<$Res> {
  _$EmailAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailAddressImplCopyWith<$Res>
    implements $EmailAddressCopyWith<$Res> {
  factory _$$EmailAddressImplCopyWith(
    _$EmailAddressImpl value,
    $Res Function(_$EmailAddressImpl) then,
  ) = __$$EmailAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String name});
}

/// @nodoc
class __$$EmailAddressImplCopyWithImpl<$Res>
    extends _$EmailAddressCopyWithImpl<$Res, _$EmailAddressImpl>
    implements _$$EmailAddressImplCopyWith<$Res> {
  __$$EmailAddressImplCopyWithImpl(
    _$EmailAddressImpl _value,
    $Res Function(_$EmailAddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null, Object? name = null}) {
    return _then(
      _$EmailAddressImpl(
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailAddressImpl implements _EmailAddress {
  const _$EmailAddressImpl({required this.email, this.name = ''});

  factory _$EmailAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailAddressImplFromJson(json);

  @override
  final String email;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'EmailAddress(email: $email, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailAddressImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, name);

  /// Create a copy of EmailAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailAddressImplCopyWith<_$EmailAddressImpl> get copyWith =>
      __$$EmailAddressImplCopyWithImpl<_$EmailAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailAddressImplToJson(this);
  }
}

abstract class _EmailAddress implements EmailAddress {
  const factory _EmailAddress({
    required final String email,
    final String name,
  }) = _$EmailAddressImpl;

  factory _EmailAddress.fromJson(Map<String, dynamic> json) =
      _$EmailAddressImpl.fromJson;

  @override
  String get email;
  @override
  String get name;

  /// Create a copy of EmailAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailAddressImplCopyWith<_$EmailAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
mixin _$Attachment {
  String get id => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  int get sizeBytes => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  bool get isInline => throw _privateConstructorUsedError;
  String? get contentId => throw _privateConstructorUsedError;

  /// Serializes this Attachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
    Attachment value,
    $Res Function(Attachment) then,
  ) = _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call({
    String id,
    String filename,
    String contentType,
    int sizeBytes,
    String? file,
    bool isInline,
    String? contentId,
  });
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filename = null,
    Object? contentType = null,
    Object? sizeBytes = null,
    Object? file = freezed,
    Object? isInline = null,
    Object? contentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            filename: null == filename
                ? _value.filename
                : filename // ignore: cast_nullable_to_non_nullable
                      as String,
            contentType: null == contentType
                ? _value.contentType
                : contentType // ignore: cast_nullable_to_non_nullable
                      as String,
            sizeBytes: null == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            file: freezed == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as String?,
            isInline: null == isInline
                ? _value.isInline
                : isInline // ignore: cast_nullable_to_non_nullable
                      as bool,
            contentId: freezed == contentId
                ? _value.contentId
                : contentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachmentImplCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$AttachmentImplCopyWith(
    _$AttachmentImpl value,
    $Res Function(_$AttachmentImpl) then,
  ) = __$$AttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String filename,
    String contentType,
    int sizeBytes,
    String? file,
    bool isInline,
    String? contentId,
  });
}

/// @nodoc
class __$$AttachmentImplCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$AttachmentImpl>
    implements _$$AttachmentImplCopyWith<$Res> {
  __$$AttachmentImplCopyWithImpl(
    _$AttachmentImpl _value,
    $Res Function(_$AttachmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filename = null,
    Object? contentType = null,
    Object? sizeBytes = null,
    Object? file = freezed,
    Object? isInline = null,
    Object? contentId = freezed,
  }) {
    return _then(
      _$AttachmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        filename: null == filename
            ? _value.filename
            : filename // ignore: cast_nullable_to_non_nullable
                  as String,
        contentType: null == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        file: freezed == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as String?,
        isInline: null == isInline
            ? _value.isInline
            : isInline // ignore: cast_nullable_to_non_nullable
                  as bool,
        contentId: freezed == contentId
            ? _value.contentId
            : contentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentImpl implements _Attachment {
  const _$AttachmentImpl({
    required this.id,
    required this.filename,
    required this.contentType,
    this.sizeBytes = 0,
    this.file,
    this.isInline = false,
    this.contentId,
  });

  factory _$AttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentImplFromJson(json);

  @override
  final String id;
  @override
  final String filename;
  @override
  final String contentType;
  @override
  @JsonKey()
  final int sizeBytes;
  @override
  final String? file;
  @override
  @JsonKey()
  final bool isInline;
  @override
  final String? contentId;

  @override
  String toString() {
    return 'Attachment(id: $id, filename: $filename, contentType: $contentType, sizeBytes: $sizeBytes, file: $file, isInline: $isInline, contentId: $contentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.isInline, isInline) ||
                other.isInline == isInline) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    filename,
    contentType,
    sizeBytes,
    file,
    isInline,
    contentId,
  );

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      __$$AttachmentImplCopyWithImpl<_$AttachmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentImplToJson(this);
  }
}

abstract class _Attachment implements Attachment {
  const factory _Attachment({
    required final String id,
    required final String filename,
    required final String contentType,
    final int sizeBytes,
    final String? file,
    final bool isInline,
    final String? contentId,
  }) = _$AttachmentImpl;

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$AttachmentImpl.fromJson;

  @override
  String get id;
  @override
  String get filename;
  @override
  String get contentType;
  @override
  int get sizeBytes;
  @override
  String? get file;
  @override
  bool get isInline;
  @override
  String? get contentId;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MailMessage _$MailMessageFromJson(Map<String, dynamic> json) {
  return _MailMessage.fromJson(json);
}

/// @nodoc
mixin _$MailMessage {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mailbox')
  String get mailboxId => throw _privateConstructorUsedError;
  @JsonKey(name: 'thread')
  String? get threadId => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get folder => throw _privateConstructorUsedError;
  String get fromAddress => throw _privateConstructorUsedError;
  String? get fromName => throw _privateConstructorUsedError;
  String? get envelopeSender => throw _privateConstructorUsedError;
  String? get envelopeRecipient => throw _privateConstructorUsedError;
  List<EmailAddress> get toAddresses => throw _privateConstructorUsedError;
  List<EmailAddress> get ccAddresses => throw _privateConstructorUsedError;
  List<EmailAddress> get bccAddresses => throw _privateConstructorUsedError;
  String? get replyTo => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String? get snippet => throw _privateConstructorUsedError;
  String? get bodyText => throw _privateConstructorUsedError;
  String? get bodyHtml => throw _privateConstructorUsedError;
  String? get rawMimeUrl => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  bool get isStarred => throw _privateConstructorUsedError;
  bool get hasAttachments => throw _privateConstructorUsedError;
  List<Attachment> get attachments => throw _privateConstructorUsedError;
  Map<String, dynamic> get rawHeaders => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime? get receivedAt => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MailMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MailMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MailMessageCopyWith<MailMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailMessageCopyWith<$Res> {
  factory $MailMessageCopyWith(
    MailMessage value,
    $Res Function(MailMessage) then,
  ) = _$MailMessageCopyWithImpl<$Res, MailMessage>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'mailbox') String mailboxId,
    @JsonKey(name: 'thread') String? threadId,
    String direction,
    String status,
    String folder,
    String fromAddress,
    String? fromName,
    String? envelopeSender,
    String? envelopeRecipient,
    List<EmailAddress> toAddresses,
    List<EmailAddress> ccAddresses,
    List<EmailAddress> bccAddresses,
    String? replyTo,
    String subject,
    String? snippet,
    String? bodyText,
    String? bodyHtml,
    String? rawMimeUrl,
    bool isRead,
    bool isStarred,
    bool hasAttachments,
    List<Attachment> attachments,
    Map<String, dynamic> rawHeaders,
    Map<String, dynamic> metadata,
    DateTime? receivedAt,
    DateTime? sentAt,
    DateTime? scheduledAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$MailMessageCopyWithImpl<$Res, $Val extends MailMessage>
    implements $MailMessageCopyWith<$Res> {
  _$MailMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MailMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mailboxId = null,
    Object? threadId = freezed,
    Object? direction = null,
    Object? status = null,
    Object? folder = null,
    Object? fromAddress = null,
    Object? fromName = freezed,
    Object? envelopeSender = freezed,
    Object? envelopeRecipient = freezed,
    Object? toAddresses = null,
    Object? ccAddresses = null,
    Object? bccAddresses = null,
    Object? replyTo = freezed,
    Object? subject = null,
    Object? snippet = freezed,
    Object? bodyText = freezed,
    Object? bodyHtml = freezed,
    Object? rawMimeUrl = freezed,
    Object? isRead = null,
    Object? isStarred = null,
    Object? hasAttachments = null,
    Object? attachments = null,
    Object? rawHeaders = null,
    Object? metadata = null,
    Object? receivedAt = freezed,
    Object? sentAt = freezed,
    Object? scheduledAt = freezed,
    Object? createdAt = freezed,
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
            threadId: freezed == threadId
                ? _value.threadId
                : threadId // ignore: cast_nullable_to_non_nullable
                      as String?,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            folder: null == folder
                ? _value.folder
                : folder // ignore: cast_nullable_to_non_nullable
                      as String,
            fromAddress: null == fromAddress
                ? _value.fromAddress
                : fromAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            fromName: freezed == fromName
                ? _value.fromName
                : fromName // ignore: cast_nullable_to_non_nullable
                      as String?,
            envelopeSender: freezed == envelopeSender
                ? _value.envelopeSender
                : envelopeSender // ignore: cast_nullable_to_non_nullable
                      as String?,
            envelopeRecipient: freezed == envelopeRecipient
                ? _value.envelopeRecipient
                : envelopeRecipient // ignore: cast_nullable_to_non_nullable
                      as String?,
            toAddresses: null == toAddresses
                ? _value.toAddresses
                : toAddresses // ignore: cast_nullable_to_non_nullable
                      as List<EmailAddress>,
            ccAddresses: null == ccAddresses
                ? _value.ccAddresses
                : ccAddresses // ignore: cast_nullable_to_non_nullable
                      as List<EmailAddress>,
            bccAddresses: null == bccAddresses
                ? _value.bccAddresses
                : bccAddresses // ignore: cast_nullable_to_non_nullable
                      as List<EmailAddress>,
            replyTo: freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                      as String?,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            snippet: freezed == snippet
                ? _value.snippet
                : snippet // ignore: cast_nullable_to_non_nullable
                      as String?,
            bodyText: freezed == bodyText
                ? _value.bodyText
                : bodyText // ignore: cast_nullable_to_non_nullable
                      as String?,
            bodyHtml: freezed == bodyHtml
                ? _value.bodyHtml
                : bodyHtml // ignore: cast_nullable_to_non_nullable
                      as String?,
            rawMimeUrl: freezed == rawMimeUrl
                ? _value.rawMimeUrl
                : rawMimeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isStarred: null == isStarred
                ? _value.isStarred
                : isStarred // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasAttachments: null == hasAttachments
                ? _value.hasAttachments
                : hasAttachments // ignore: cast_nullable_to_non_nullable
                      as bool,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<Attachment>,
            rawHeaders: null == rawHeaders
                ? _value.rawHeaders
                : rawHeaders // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            receivedAt: freezed == receivedAt
                ? _value.receivedAt
                : receivedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            sentAt: freezed == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MailMessageImplCopyWith<$Res>
    implements $MailMessageCopyWith<$Res> {
  factory _$$MailMessageImplCopyWith(
    _$MailMessageImpl value,
    $Res Function(_$MailMessageImpl) then,
  ) = __$$MailMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'mailbox') String mailboxId,
    @JsonKey(name: 'thread') String? threadId,
    String direction,
    String status,
    String folder,
    String fromAddress,
    String? fromName,
    String? envelopeSender,
    String? envelopeRecipient,
    List<EmailAddress> toAddresses,
    List<EmailAddress> ccAddresses,
    List<EmailAddress> bccAddresses,
    String? replyTo,
    String subject,
    String? snippet,
    String? bodyText,
    String? bodyHtml,
    String? rawMimeUrl,
    bool isRead,
    bool isStarred,
    bool hasAttachments,
    List<Attachment> attachments,
    Map<String, dynamic> rawHeaders,
    Map<String, dynamic> metadata,
    DateTime? receivedAt,
    DateTime? sentAt,
    DateTime? scheduledAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$MailMessageImplCopyWithImpl<$Res>
    extends _$MailMessageCopyWithImpl<$Res, _$MailMessageImpl>
    implements _$$MailMessageImplCopyWith<$Res> {
  __$$MailMessageImplCopyWithImpl(
    _$MailMessageImpl _value,
    $Res Function(_$MailMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MailMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mailboxId = null,
    Object? threadId = freezed,
    Object? direction = null,
    Object? status = null,
    Object? folder = null,
    Object? fromAddress = null,
    Object? fromName = freezed,
    Object? envelopeSender = freezed,
    Object? envelopeRecipient = freezed,
    Object? toAddresses = null,
    Object? ccAddresses = null,
    Object? bccAddresses = null,
    Object? replyTo = freezed,
    Object? subject = null,
    Object? snippet = freezed,
    Object? bodyText = freezed,
    Object? bodyHtml = freezed,
    Object? rawMimeUrl = freezed,
    Object? isRead = null,
    Object? isStarred = null,
    Object? hasAttachments = null,
    Object? attachments = null,
    Object? rawHeaders = null,
    Object? metadata = null,
    Object? receivedAt = freezed,
    Object? sentAt = freezed,
    Object? scheduledAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$MailMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mailboxId: null == mailboxId
            ? _value.mailboxId
            : mailboxId // ignore: cast_nullable_to_non_nullable
                  as String,
        threadId: freezed == threadId
            ? _value.threadId
            : threadId // ignore: cast_nullable_to_non_nullable
                  as String?,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        folder: null == folder
            ? _value.folder
            : folder // ignore: cast_nullable_to_non_nullable
                  as String,
        fromAddress: null == fromAddress
            ? _value.fromAddress
            : fromAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        fromName: freezed == fromName
            ? _value.fromName
            : fromName // ignore: cast_nullable_to_non_nullable
                  as String?,
        envelopeSender: freezed == envelopeSender
            ? _value.envelopeSender
            : envelopeSender // ignore: cast_nullable_to_non_nullable
                  as String?,
        envelopeRecipient: freezed == envelopeRecipient
            ? _value.envelopeRecipient
            : envelopeRecipient // ignore: cast_nullable_to_non_nullable
                  as String?,
        toAddresses: null == toAddresses
            ? _value._toAddresses
            : toAddresses // ignore: cast_nullable_to_non_nullable
                  as List<EmailAddress>,
        ccAddresses: null == ccAddresses
            ? _value._ccAddresses
            : ccAddresses // ignore: cast_nullable_to_non_nullable
                  as List<EmailAddress>,
        bccAddresses: null == bccAddresses
            ? _value._bccAddresses
            : bccAddresses // ignore: cast_nullable_to_non_nullable
                  as List<EmailAddress>,
        replyTo: freezed == replyTo
            ? _value.replyTo
            : replyTo // ignore: cast_nullable_to_non_nullable
                  as String?,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        snippet: freezed == snippet
            ? _value.snippet
            : snippet // ignore: cast_nullable_to_non_nullable
                  as String?,
        bodyText: freezed == bodyText
            ? _value.bodyText
            : bodyText // ignore: cast_nullable_to_non_nullable
                  as String?,
        bodyHtml: freezed == bodyHtml
            ? _value.bodyHtml
            : bodyHtml // ignore: cast_nullable_to_non_nullable
                  as String?,
        rawMimeUrl: freezed == rawMimeUrl
            ? _value.rawMimeUrl
            : rawMimeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isStarred: null == isStarred
            ? _value.isStarred
            : isStarred // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasAttachments: null == hasAttachments
            ? _value.hasAttachments
            : hasAttachments // ignore: cast_nullable_to_non_nullable
                  as bool,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<Attachment>,
        rawHeaders: null == rawHeaders
            ? _value._rawHeaders
            : rawHeaders // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        receivedAt: freezed == receivedAt
            ? _value.receivedAt
            : receivedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        sentAt: freezed == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
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
class _$MailMessageImpl implements _MailMessage {
  const _$MailMessageImpl({
    required this.id,
    @JsonKey(name: 'mailbox') required this.mailboxId,
    @JsonKey(name: 'thread') this.threadId,
    required this.direction,
    required this.status,
    this.folder = 'inbox',
    required this.fromAddress,
    this.fromName,
    this.envelopeSender,
    this.envelopeRecipient,
    final List<EmailAddress> toAddresses = const [],
    final List<EmailAddress> ccAddresses = const [],
    final List<EmailAddress> bccAddresses = const [],
    this.replyTo,
    required this.subject,
    this.snippet,
    this.bodyText,
    this.bodyHtml,
    this.rawMimeUrl,
    this.isRead = false,
    this.isStarred = false,
    this.hasAttachments = false,
    final List<Attachment> attachments = const [],
    final Map<String, dynamic> rawHeaders = const {},
    final Map<String, dynamic> metadata = const {},
    this.receivedAt,
    this.sentAt,
    this.scheduledAt,
    this.createdAt,
  }) : _toAddresses = toAddresses,
       _ccAddresses = ccAddresses,
       _bccAddresses = bccAddresses,
       _attachments = attachments,
       _rawHeaders = rawHeaders,
       _metadata = metadata;

  factory _$MailMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailMessageImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'mailbox')
  final String mailboxId;
  @override
  @JsonKey(name: 'thread')
  final String? threadId;
  @override
  final String direction;
  @override
  final String status;
  @override
  @JsonKey()
  final String folder;
  @override
  final String fromAddress;
  @override
  final String? fromName;
  @override
  final String? envelopeSender;
  @override
  final String? envelopeRecipient;
  final List<EmailAddress> _toAddresses;
  @override
  @JsonKey()
  List<EmailAddress> get toAddresses {
    if (_toAddresses is EqualUnmodifiableListView) return _toAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toAddresses);
  }

  final List<EmailAddress> _ccAddresses;
  @override
  @JsonKey()
  List<EmailAddress> get ccAddresses {
    if (_ccAddresses is EqualUnmodifiableListView) return _ccAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ccAddresses);
  }

  final List<EmailAddress> _bccAddresses;
  @override
  @JsonKey()
  List<EmailAddress> get bccAddresses {
    if (_bccAddresses is EqualUnmodifiableListView) return _bccAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bccAddresses);
  }

  @override
  final String? replyTo;
  @override
  final String subject;
  @override
  final String? snippet;
  @override
  final String? bodyText;
  @override
  final String? bodyHtml;
  @override
  final String? rawMimeUrl;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isStarred;
  @override
  @JsonKey()
  final bool hasAttachments;
  final List<Attachment> _attachments;
  @override
  @JsonKey()
  List<Attachment> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  final Map<String, dynamic> _rawHeaders;
  @override
  @JsonKey()
  Map<String, dynamic> get rawHeaders {
    if (_rawHeaders is EqualUnmodifiableMapView) return _rawHeaders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rawHeaders);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime? receivedAt;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? scheduledAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MailMessage(id: $id, mailboxId: $mailboxId, threadId: $threadId, direction: $direction, status: $status, folder: $folder, fromAddress: $fromAddress, fromName: $fromName, envelopeSender: $envelopeSender, envelopeRecipient: $envelopeRecipient, toAddresses: $toAddresses, ccAddresses: $ccAddresses, bccAddresses: $bccAddresses, replyTo: $replyTo, subject: $subject, snippet: $snippet, bodyText: $bodyText, bodyHtml: $bodyHtml, rawMimeUrl: $rawMimeUrl, isRead: $isRead, isStarred: $isStarred, hasAttachments: $hasAttachments, attachments: $attachments, rawHeaders: $rawHeaders, metadata: $metadata, receivedAt: $receivedAt, sentAt: $sentAt, scheduledAt: $scheduledAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mailboxId, mailboxId) ||
                other.mailboxId == mailboxId) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.folder, folder) || other.folder == folder) &&
            (identical(other.fromAddress, fromAddress) ||
                other.fromAddress == fromAddress) &&
            (identical(other.fromName, fromName) ||
                other.fromName == fromName) &&
            (identical(other.envelopeSender, envelopeSender) ||
                other.envelopeSender == envelopeSender) &&
            (identical(other.envelopeRecipient, envelopeRecipient) ||
                other.envelopeRecipient == envelopeRecipient) &&
            const DeepCollectionEquality().equals(
              other._toAddresses,
              _toAddresses,
            ) &&
            const DeepCollectionEquality().equals(
              other._ccAddresses,
              _ccAddresses,
            ) &&
            const DeepCollectionEquality().equals(
              other._bccAddresses,
              _bccAddresses,
            ) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.snippet, snippet) || other.snippet == snippet) &&
            (identical(other.bodyText, bodyText) ||
                other.bodyText == bodyText) &&
            (identical(other.bodyHtml, bodyHtml) ||
                other.bodyHtml == bodyHtml) &&
            (identical(other.rawMimeUrl, rawMimeUrl) ||
                other.rawMimeUrl == rawMimeUrl) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isStarred, isStarred) ||
                other.isStarred == isStarred) &&
            (identical(other.hasAttachments, hasAttachments) ||
                other.hasAttachments == hasAttachments) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            const DeepCollectionEquality().equals(
              other._rawHeaders,
              _rawHeaders,
            ) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    mailboxId,
    threadId,
    direction,
    status,
    folder,
    fromAddress,
    fromName,
    envelopeSender,
    envelopeRecipient,
    const DeepCollectionEquality().hash(_toAddresses),
    const DeepCollectionEquality().hash(_ccAddresses),
    const DeepCollectionEquality().hash(_bccAddresses),
    replyTo,
    subject,
    snippet,
    bodyText,
    bodyHtml,
    rawMimeUrl,
    isRead,
    isStarred,
    hasAttachments,
    const DeepCollectionEquality().hash(_attachments),
    const DeepCollectionEquality().hash(_rawHeaders),
    const DeepCollectionEquality().hash(_metadata),
    receivedAt,
    sentAt,
    scheduledAt,
    createdAt,
  ]);

  /// Create a copy of MailMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MailMessageImplCopyWith<_$MailMessageImpl> get copyWith =>
      __$$MailMessageImplCopyWithImpl<_$MailMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailMessageImplToJson(this);
  }
}

abstract class _MailMessage implements MailMessage {
  const factory _MailMessage({
    required final String id,
    @JsonKey(name: 'mailbox') required final String mailboxId,
    @JsonKey(name: 'thread') final String? threadId,
    required final String direction,
    required final String status,
    final String folder,
    required final String fromAddress,
    final String? fromName,
    final String? envelopeSender,
    final String? envelopeRecipient,
    final List<EmailAddress> toAddresses,
    final List<EmailAddress> ccAddresses,
    final List<EmailAddress> bccAddresses,
    final String? replyTo,
    required final String subject,
    final String? snippet,
    final String? bodyText,
    final String? bodyHtml,
    final String? rawMimeUrl,
    final bool isRead,
    final bool isStarred,
    final bool hasAttachments,
    final List<Attachment> attachments,
    final Map<String, dynamic> rawHeaders,
    final Map<String, dynamic> metadata,
    final DateTime? receivedAt,
    final DateTime? sentAt,
    final DateTime? scheduledAt,
    final DateTime? createdAt,
  }) = _$MailMessageImpl;

  factory _MailMessage.fromJson(Map<String, dynamic> json) =
      _$MailMessageImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'mailbox')
  String get mailboxId;
  @override
  @JsonKey(name: 'thread')
  String? get threadId;
  @override
  String get direction;
  @override
  String get status;
  @override
  String get folder;
  @override
  String get fromAddress;
  @override
  String? get fromName;
  @override
  String? get envelopeSender;
  @override
  String? get envelopeRecipient;
  @override
  List<EmailAddress> get toAddresses;
  @override
  List<EmailAddress> get ccAddresses;
  @override
  List<EmailAddress> get bccAddresses;
  @override
  String? get replyTo;
  @override
  String get subject;
  @override
  String? get snippet;
  @override
  String? get bodyText;
  @override
  String? get bodyHtml;
  @override
  String? get rawMimeUrl;
  @override
  bool get isRead;
  @override
  bool get isStarred;
  @override
  bool get hasAttachments;
  @override
  List<Attachment> get attachments;
  @override
  Map<String, dynamic> get rawHeaders;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime? get receivedAt;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get scheduledAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of MailMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MailMessageImplCopyWith<_$MailMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) {
  return _SendMessageRequest.fromJson(json);
}

/// @nodoc
mixin _$SendMessageRequest {
  String get mailboxId => throw _privateConstructorUsedError;
  String? get senderIdentityId => throw _privateConstructorUsedError;
  List<EmailAddress> get to => throw _privateConstructorUsedError;
  List<EmailAddress> get cc => throw _privateConstructorUsedError;
  List<EmailAddress> get bcc => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String? get bodyText => throw _privateConstructorUsedError;
  String? get bodyHtml => throw _privateConstructorUsedError;
  String? get replyToMessageId => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;

  /// Serializes this SendMessageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageRequestCopyWith<SendMessageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageRequestCopyWith<$Res> {
  factory $SendMessageRequestCopyWith(
    SendMessageRequest value,
    $Res Function(SendMessageRequest) then,
  ) = _$SendMessageRequestCopyWithImpl<$Res, SendMessageRequest>;
  @useResult
  $Res call({
    String mailboxId,
    String? senderIdentityId,
    List<EmailAddress> to,
    List<EmailAddress> cc,
    List<EmailAddress> bcc,
    String subject,
    String? bodyText,
    String? bodyHtml,
    String? replyToMessageId,
    DateTime? scheduledAt,
  });
}

/// @nodoc
class _$SendMessageRequestCopyWithImpl<$Res, $Val extends SendMessageRequest>
    implements $SendMessageRequestCopyWith<$Res> {
  _$SendMessageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mailboxId = null,
    Object? senderIdentityId = freezed,
    Object? to = null,
    Object? cc = null,
    Object? bcc = null,
    Object? subject = null,
    Object? bodyText = freezed,
    Object? bodyHtml = freezed,
    Object? replyToMessageId = freezed,
    Object? scheduledAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            mailboxId: null == mailboxId
                ? _value.mailboxId
                : mailboxId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderIdentityId: freezed == senderIdentityId
                ? _value.senderIdentityId
                : senderIdentityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as List<EmailAddress>,
            cc: null == cc
                ? _value.cc
                : cc // ignore: cast_nullable_to_non_nullable
                      as List<EmailAddress>,
            bcc: null == bcc
                ? _value.bcc
                : bcc // ignore: cast_nullable_to_non_nullable
                      as List<EmailAddress>,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            bodyText: freezed == bodyText
                ? _value.bodyText
                : bodyText // ignore: cast_nullable_to_non_nullable
                      as String?,
            bodyHtml: freezed == bodyHtml
                ? _value.bodyHtml
                : bodyHtml // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyToMessageId: freezed == replyToMessageId
                ? _value.replyToMessageId
                : replyToMessageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SendMessageRequestImplCopyWith<$Res>
    implements $SendMessageRequestCopyWith<$Res> {
  factory _$$SendMessageRequestImplCopyWith(
    _$SendMessageRequestImpl value,
    $Res Function(_$SendMessageRequestImpl) then,
  ) = __$$SendMessageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String mailboxId,
    String? senderIdentityId,
    List<EmailAddress> to,
    List<EmailAddress> cc,
    List<EmailAddress> bcc,
    String subject,
    String? bodyText,
    String? bodyHtml,
    String? replyToMessageId,
    DateTime? scheduledAt,
  });
}

/// @nodoc
class __$$SendMessageRequestImplCopyWithImpl<$Res>
    extends _$SendMessageRequestCopyWithImpl<$Res, _$SendMessageRequestImpl>
    implements _$$SendMessageRequestImplCopyWith<$Res> {
  __$$SendMessageRequestImplCopyWithImpl(
    _$SendMessageRequestImpl _value,
    $Res Function(_$SendMessageRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mailboxId = null,
    Object? senderIdentityId = freezed,
    Object? to = null,
    Object? cc = null,
    Object? bcc = null,
    Object? subject = null,
    Object? bodyText = freezed,
    Object? bodyHtml = freezed,
    Object? replyToMessageId = freezed,
    Object? scheduledAt = freezed,
  }) {
    return _then(
      _$SendMessageRequestImpl(
        mailboxId: null == mailboxId
            ? _value.mailboxId
            : mailboxId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderIdentityId: freezed == senderIdentityId
            ? _value.senderIdentityId
            : senderIdentityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        to: null == to
            ? _value._to
            : to // ignore: cast_nullable_to_non_nullable
                  as List<EmailAddress>,
        cc: null == cc
            ? _value._cc
            : cc // ignore: cast_nullable_to_non_nullable
                  as List<EmailAddress>,
        bcc: null == bcc
            ? _value._bcc
            : bcc // ignore: cast_nullable_to_non_nullable
                  as List<EmailAddress>,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        bodyText: freezed == bodyText
            ? _value.bodyText
            : bodyText // ignore: cast_nullable_to_non_nullable
                  as String?,
        bodyHtml: freezed == bodyHtml
            ? _value.bodyHtml
            : bodyHtml // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyToMessageId: freezed == replyToMessageId
            ? _value.replyToMessageId
            : replyToMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageRequestImpl implements _SendMessageRequest {
  const _$SendMessageRequestImpl({
    required this.mailboxId,
    this.senderIdentityId,
    required final List<EmailAddress> to,
    final List<EmailAddress> cc = const [],
    final List<EmailAddress> bcc = const [],
    required this.subject,
    this.bodyText,
    this.bodyHtml,
    this.replyToMessageId,
    this.scheduledAt,
  }) : _to = to,
       _cc = cc,
       _bcc = bcc;

  factory _$SendMessageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageRequestImplFromJson(json);

  @override
  final String mailboxId;
  @override
  final String? senderIdentityId;
  final List<EmailAddress> _to;
  @override
  List<EmailAddress> get to {
    if (_to is EqualUnmodifiableListView) return _to;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_to);
  }

  final List<EmailAddress> _cc;
  @override
  @JsonKey()
  List<EmailAddress> get cc {
    if (_cc is EqualUnmodifiableListView) return _cc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cc);
  }

  final List<EmailAddress> _bcc;
  @override
  @JsonKey()
  List<EmailAddress> get bcc {
    if (_bcc is EqualUnmodifiableListView) return _bcc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bcc);
  }

  @override
  final String subject;
  @override
  final String? bodyText;
  @override
  final String? bodyHtml;
  @override
  final String? replyToMessageId;
  @override
  final DateTime? scheduledAt;

  @override
  String toString() {
    return 'SendMessageRequest(mailboxId: $mailboxId, senderIdentityId: $senderIdentityId, to: $to, cc: $cc, bcc: $bcc, subject: $subject, bodyText: $bodyText, bodyHtml: $bodyHtml, replyToMessageId: $replyToMessageId, scheduledAt: $scheduledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageRequestImpl &&
            (identical(other.mailboxId, mailboxId) ||
                other.mailboxId == mailboxId) &&
            (identical(other.senderIdentityId, senderIdentityId) ||
                other.senderIdentityId == senderIdentityId) &&
            const DeepCollectionEquality().equals(other._to, _to) &&
            const DeepCollectionEquality().equals(other._cc, _cc) &&
            const DeepCollectionEquality().equals(other._bcc, _bcc) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.bodyText, bodyText) ||
                other.bodyText == bodyText) &&
            (identical(other.bodyHtml, bodyHtml) ||
                other.bodyHtml == bodyHtml) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mailboxId,
    senderIdentityId,
    const DeepCollectionEquality().hash(_to),
    const DeepCollectionEquality().hash(_cc),
    const DeepCollectionEquality().hash(_bcc),
    subject,
    bodyText,
    bodyHtml,
    replyToMessageId,
    scheduledAt,
  );

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageRequestImplCopyWith<_$SendMessageRequestImpl> get copyWith =>
      __$$SendMessageRequestImplCopyWithImpl<_$SendMessageRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageRequestImplToJson(this);
  }
}

abstract class _SendMessageRequest implements SendMessageRequest {
  const factory _SendMessageRequest({
    required final String mailboxId,
    final String? senderIdentityId,
    required final List<EmailAddress> to,
    final List<EmailAddress> cc,
    final List<EmailAddress> bcc,
    required final String subject,
    final String? bodyText,
    final String? bodyHtml,
    final String? replyToMessageId,
    final DateTime? scheduledAt,
  }) = _$SendMessageRequestImpl;

  factory _SendMessageRequest.fromJson(Map<String, dynamic> json) =
      _$SendMessageRequestImpl.fromJson;

  @override
  String get mailboxId;
  @override
  String? get senderIdentityId;
  @override
  List<EmailAddress> get to;
  @override
  List<EmailAddress> get cc;
  @override
  List<EmailAddress> get bcc;
  @override
  String get subject;
  @override
  String? get bodyText;
  @override
  String? get bodyHtml;
  @override
  String? get replyToMessageId;
  @override
  DateTime? get scheduledAt;

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageRequestImplCopyWith<_$SendMessageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
