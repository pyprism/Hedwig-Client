// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MailThread _$MailThreadFromJson(Map<String, dynamic> json) {
  return _MailThread.fromJson(json);
}

/// @nodoc
mixin _$MailThread {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mailbox')
  String get mailboxId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  List<String> get participants => throw _privateConstructorUsedError;
  int get messageCount => throw _privateConstructorUsedError;
  bool get hasUnread => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  String? get snippet => throw _privateConstructorUsedError;
  String? get latestDirection => throw _privateConstructorUsedError;
  bool get hasAttachments => throw _privateConstructorUsedError;
  List<String> get attachmentFilenames => throw _privateConstructorUsedError;
  List<ThreadLabel> get labels => throw _privateConstructorUsedError;
  String? get searchHighlight => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MailThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MailThreadCopyWith<MailThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailThreadCopyWith<$Res> {
  factory $MailThreadCopyWith(
    MailThread value,
    $Res Function(MailThread) then,
  ) = _$MailThreadCopyWithImpl<$Res, MailThread>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'mailbox') String mailboxId,
    String subject,
    List<String> participants,
    int messageCount,
    bool hasUnread,
    int unreadCount,
    String? snippet,
    String? latestDirection,
    bool hasAttachments,
    List<String> attachmentFilenames,
    List<ThreadLabel> labels,
    String? searchHighlight,
    DateTime? lastMessageAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$MailThreadCopyWithImpl<$Res, $Val extends MailThread>
    implements $MailThreadCopyWith<$Res> {
  _$MailThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mailboxId = null,
    Object? subject = null,
    Object? participants = null,
    Object? messageCount = null,
    Object? hasUnread = null,
    Object? unreadCount = null,
    Object? snippet = freezed,
    Object? latestDirection = freezed,
    Object? hasAttachments = null,
    Object? attachmentFilenames = null,
    Object? labels = null,
    Object? searchHighlight = freezed,
    Object? lastMessageAt = freezed,
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
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            messageCount: null == messageCount
                ? _value.messageCount
                : messageCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasUnread: null == hasUnread
                ? _value.hasUnread
                : hasUnread // ignore: cast_nullable_to_non_nullable
                      as bool,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            snippet: freezed == snippet
                ? _value.snippet
                : snippet // ignore: cast_nullable_to_non_nullable
                      as String?,
            latestDirection: freezed == latestDirection
                ? _value.latestDirection
                : latestDirection // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasAttachments: null == hasAttachments
                ? _value.hasAttachments
                : hasAttachments // ignore: cast_nullable_to_non_nullable
                      as bool,
            attachmentFilenames: null == attachmentFilenames
                ? _value.attachmentFilenames
                : attachmentFilenames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            labels: null == labels
                ? _value.labels
                : labels // ignore: cast_nullable_to_non_nullable
                      as List<ThreadLabel>,
            searchHighlight: freezed == searchHighlight
                ? _value.searchHighlight
                : searchHighlight // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: freezed == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MailThreadImplCopyWith<$Res>
    implements $MailThreadCopyWith<$Res> {
  factory _$$MailThreadImplCopyWith(
    _$MailThreadImpl value,
    $Res Function(_$MailThreadImpl) then,
  ) = __$$MailThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'mailbox') String mailboxId,
    String subject,
    List<String> participants,
    int messageCount,
    bool hasUnread,
    int unreadCount,
    String? snippet,
    String? latestDirection,
    bool hasAttachments,
    List<String> attachmentFilenames,
    List<ThreadLabel> labels,
    String? searchHighlight,
    DateTime? lastMessageAt,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$MailThreadImplCopyWithImpl<$Res>
    extends _$MailThreadCopyWithImpl<$Res, _$MailThreadImpl>
    implements _$$MailThreadImplCopyWith<$Res> {
  __$$MailThreadImplCopyWithImpl(
    _$MailThreadImpl _value,
    $Res Function(_$MailThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mailboxId = null,
    Object? subject = null,
    Object? participants = null,
    Object? messageCount = null,
    Object? hasUnread = null,
    Object? unreadCount = null,
    Object? snippet = freezed,
    Object? latestDirection = freezed,
    Object? hasAttachments = null,
    Object? attachmentFilenames = null,
    Object? labels = null,
    Object? searchHighlight = freezed,
    Object? lastMessageAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$MailThreadImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mailboxId: null == mailboxId
            ? _value.mailboxId
            : mailboxId // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        messageCount: null == messageCount
            ? _value.messageCount
            : messageCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasUnread: null == hasUnread
            ? _value.hasUnread
            : hasUnread // ignore: cast_nullable_to_non_nullable
                  as bool,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        snippet: freezed == snippet
            ? _value.snippet
            : snippet // ignore: cast_nullable_to_non_nullable
                  as String?,
        latestDirection: freezed == latestDirection
            ? _value.latestDirection
            : latestDirection // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasAttachments: null == hasAttachments
            ? _value.hasAttachments
            : hasAttachments // ignore: cast_nullable_to_non_nullable
                  as bool,
        attachmentFilenames: null == attachmentFilenames
            ? _value._attachmentFilenames
            : attachmentFilenames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        labels: null == labels
            ? _value._labels
            : labels // ignore: cast_nullable_to_non_nullable
                  as List<ThreadLabel>,
        searchHighlight: freezed == searchHighlight
            ? _value.searchHighlight
            : searchHighlight // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: freezed == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
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
class _$MailThreadImpl implements _MailThread {
  const _$MailThreadImpl({
    required this.id,
    @JsonKey(name: 'mailbox') required this.mailboxId,
    required this.subject,
    final List<String> participants = const [],
    this.messageCount = 0,
    this.hasUnread = false,
    this.unreadCount = 0,
    this.snippet,
    this.latestDirection,
    this.hasAttachments = false,
    final List<String> attachmentFilenames = const [],
    final List<ThreadLabel> labels = const [],
    this.searchHighlight,
    this.lastMessageAt,
    this.createdAt,
  }) : _participants = participants,
       _attachmentFilenames = attachmentFilenames,
       _labels = labels;

  factory _$MailThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailThreadImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'mailbox')
  final String mailboxId;
  @override
  final String subject;
  final List<String> _participants;
  @override
  @JsonKey()
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  @JsonKey()
  final int messageCount;
  @override
  @JsonKey()
  final bool hasUnread;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final String? snippet;
  @override
  final String? latestDirection;
  @override
  @JsonKey()
  final bool hasAttachments;
  final List<String> _attachmentFilenames;
  @override
  @JsonKey()
  List<String> get attachmentFilenames {
    if (_attachmentFilenames is EqualUnmodifiableListView)
      return _attachmentFilenames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentFilenames);
  }

  final List<ThreadLabel> _labels;
  @override
  @JsonKey()
  List<ThreadLabel> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  @override
  final String? searchHighlight;
  @override
  final DateTime? lastMessageAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MailThread(id: $id, mailboxId: $mailboxId, subject: $subject, participants: $participants, messageCount: $messageCount, hasUnread: $hasUnread, unreadCount: $unreadCount, snippet: $snippet, latestDirection: $latestDirection, hasAttachments: $hasAttachments, attachmentFilenames: $attachmentFilenames, labels: $labels, searchHighlight: $searchHighlight, lastMessageAt: $lastMessageAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mailboxId, mailboxId) ||
                other.mailboxId == mailboxId) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.messageCount, messageCount) ||
                other.messageCount == messageCount) &&
            (identical(other.hasUnread, hasUnread) ||
                other.hasUnread == hasUnread) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.snippet, snippet) || other.snippet == snippet) &&
            (identical(other.latestDirection, latestDirection) ||
                other.latestDirection == latestDirection) &&
            (identical(other.hasAttachments, hasAttachments) ||
                other.hasAttachments == hasAttachments) &&
            const DeepCollectionEquality().equals(
              other._attachmentFilenames,
              _attachmentFilenames,
            ) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.searchHighlight, searchHighlight) ||
                other.searchHighlight == searchHighlight) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    mailboxId,
    subject,
    const DeepCollectionEquality().hash(_participants),
    messageCount,
    hasUnread,
    unreadCount,
    snippet,
    latestDirection,
    hasAttachments,
    const DeepCollectionEquality().hash(_attachmentFilenames),
    const DeepCollectionEquality().hash(_labels),
    searchHighlight,
    lastMessageAt,
    createdAt,
  );

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MailThreadImplCopyWith<_$MailThreadImpl> get copyWith =>
      __$$MailThreadImplCopyWithImpl<_$MailThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailThreadImplToJson(this);
  }
}

abstract class _MailThread implements MailThread {
  const factory _MailThread({
    required final String id,
    @JsonKey(name: 'mailbox') required final String mailboxId,
    required final String subject,
    final List<String> participants,
    final int messageCount,
    final bool hasUnread,
    final int unreadCount,
    final String? snippet,
    final String? latestDirection,
    final bool hasAttachments,
    final List<String> attachmentFilenames,
    final List<ThreadLabel> labels,
    final String? searchHighlight,
    final DateTime? lastMessageAt,
    final DateTime? createdAt,
  }) = _$MailThreadImpl;

  factory _MailThread.fromJson(Map<String, dynamic> json) =
      _$MailThreadImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'mailbox')
  String get mailboxId;
  @override
  String get subject;
  @override
  List<String> get participants;
  @override
  int get messageCount;
  @override
  bool get hasUnread;
  @override
  int get unreadCount;
  @override
  String? get snippet;
  @override
  String? get latestDirection;
  @override
  bool get hasAttachments;
  @override
  List<String> get attachmentFilenames;
  @override
  List<ThreadLabel> get labels;
  @override
  String? get searchHighlight;
  @override
  DateTime? get lastMessageAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MailThreadImplCopyWith<_$MailThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThreadLabel _$ThreadLabelFromJson(Map<String, dynamic> json) {
  return _ThreadLabel.fromJson(json);
}

/// @nodoc
mixin _$ThreadLabel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this ThreadLabel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThreadLabel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThreadLabelCopyWith<ThreadLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadLabelCopyWith<$Res> {
  factory $ThreadLabelCopyWith(
    ThreadLabel value,
    $Res Function(ThreadLabel) then,
  ) = _$ThreadLabelCopyWithImpl<$Res, ThreadLabel>;
  @useResult
  $Res call({String id, String name, String? color});
}

/// @nodoc
class _$ThreadLabelCopyWithImpl<$Res, $Val extends ThreadLabel>
    implements $ThreadLabelCopyWith<$Res> {
  _$ThreadLabelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreadLabel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? color = freezed}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThreadLabelImplCopyWith<$Res>
    implements $ThreadLabelCopyWith<$Res> {
  factory _$$ThreadLabelImplCopyWith(
    _$ThreadLabelImpl value,
    $Res Function(_$ThreadLabelImpl) then,
  ) = __$$ThreadLabelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? color});
}

/// @nodoc
class __$$ThreadLabelImplCopyWithImpl<$Res>
    extends _$ThreadLabelCopyWithImpl<$Res, _$ThreadLabelImpl>
    implements _$$ThreadLabelImplCopyWith<$Res> {
  __$$ThreadLabelImplCopyWithImpl(
    _$ThreadLabelImpl _value,
    $Res Function(_$ThreadLabelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThreadLabel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? color = freezed}) {
    return _then(
      _$ThreadLabelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreadLabelImpl implements _ThreadLabel {
  const _$ThreadLabelImpl({required this.id, required this.name, this.color});

  factory _$ThreadLabelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreadLabelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;

  @override
  String toString() {
    return 'ThreadLabel(id: $id, name: $name, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadLabelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color);

  /// Create a copy of ThreadLabel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadLabelImplCopyWith<_$ThreadLabelImpl> get copyWith =>
      __$$ThreadLabelImplCopyWithImpl<_$ThreadLabelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreadLabelImplToJson(this);
  }
}

abstract class _ThreadLabel implements ThreadLabel {
  const factory _ThreadLabel({
    required final String id,
    required final String name,
    final String? color,
  }) = _$ThreadLabelImpl;

  factory _ThreadLabel.fromJson(Map<String, dynamic> json) =
      _$ThreadLabelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get color;

  /// Create a copy of ThreadLabel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThreadLabelImplCopyWith<_$ThreadLabelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
