import 'package:drift/drift.dart';

// ignore_for_file: avoid_classes_with_only_static_members

@DataClassName('MailboxRow')
class Mailboxes extends Table {
  TextColumn get id => text()();
  TextColumn get domainId => text()();
  TextColumn get localPart => text()();
  TextColumn get emailAddress => text()();
  TextColumn get displayName => text().nullable()();
  BoolColumn get sendEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get receiveEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get quotaBytes => integer().withDefault(const Constant(0))();
  IntColumn get usedBytes => integer().withDefault(const Constant(0))();
  TextColumn get signatureHtml => text().nullable()();
  TextColumn get signatureText => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ThreadRow')
class Threads extends Table {
  TextColumn get id => text()();
  TextColumn get mailboxId => text()();
  TextColumn get subject => text()();
  IntColumn get messageCount => integer().withDefault(const Constant(0))();
  BoolColumn get hasUnread => boolean().withDefault(const Constant(false))();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  TextColumn get snippet => text().nullable()();
  TextColumn get latestDirection => text().nullable()();
  BoolColumn get hasAttachments =>
      boolean().withDefault(const Constant(false))();
  TextColumn get attachmentFilenamesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get labelsJson => text().withDefault(const Constant('[]'))();
  TextColumn get searchHighlight => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime()();
  TextColumn get participantsJson => text().withDefault(const Constant('[]'))();
  TextColumn get folder => text().withDefault(const Constant('inbox'))();
  DateTimeColumn get updatedAt => dateTime()();

  // Folder is per-message server-side, so one thread can appear in several
  // folders at once. The cache key is (id, folder), not id alone.
  @override
  Set<Column> get primaryKey => {id, folder};
}

@DataClassName('MessageRow')
class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get mailboxId => text()();
  TextColumn get threadId => text().nullable()();
  TextColumn get direction => text()(); // inbound | outbound
  TextColumn get status => text()();
  TextColumn get folder => text().withDefault(const Constant('inbox'))();
  TextColumn get fromAddress => text()();
  TextColumn get fromName => text().nullable()();
  TextColumn get envelopeSender => text().nullable()();
  TextColumn get envelopeRecipient => text().nullable()();
  TextColumn get toAddressesJson => text().withDefault(const Constant('[]'))();
  TextColumn get ccAddressesJson => text().withDefault(const Constant('[]'))();
  TextColumn get bccAddressesJson => text().withDefault(const Constant('[]'))();
  TextColumn get replyTo => text().nullable()();
  TextColumn get subject => text()();
  TextColumn get snippet => text().nullable()();
  TextColumn get bodyText => text().nullable()();
  TextColumn get bodyHtml => text().nullable()();
  TextColumn get rawMimeUrl => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();
  BoolColumn get hasAttachments =>
      boolean().withDefault(const Constant(false))();
  TextColumn get attachmentsJson => text().withDefault(const Constant('[]'))();
  TextColumn get rawHeadersJson => text().withDefault(const Constant('{}'))();
  TextColumn get metadataJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get receivedAt => dateTime().nullable()();
  DateTimeColumn get sentAt => dateTime().nullable()();
  DateTimeColumn get scheduledAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ContactRow')
class Contacts extends Table {
  TextColumn get id => text()();
  TextColumn get mailboxId => text()();
  TextColumn get email => text()();
  TextColumn get name => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get timesContacted => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastContactedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LabelRow')
class Labels extends Table {
  TextColumn get id => text()();
  TextColumn get mailboxId => text()();
  TextColumn get name => text()();
  TextColumn get color => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MessageLabelCacheRow')
class MessageLabelCache extends Table {
  TextColumn get messageId => text()();
  TextColumn get labelId => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {messageId, labelId};
}

@DataClassName('MessageUserStateRow')
class MessageUserStates extends Table {
  TextColumn get messageId => text()();
  TextColumn get folder => text().withDefault(const Constant('inbox'))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();
  BoolColumn get isImportant => boolean().withDefault(const Constant(false))();
  DateTimeColumn get snoozedUntil => dateTime().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {messageId};
}

@DataClassName('SyncMetaRow')
class SyncMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

/// Outbox: queued writes waiting to be flushed when online.
class OutboxEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operation => text()(); // send_message | state_change | etc.
  TextColumn get payloadJson => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
