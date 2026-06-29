import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/db/daos/contact_dao.dart';
import 'package:hedwig_client/core/db/daos/label_dao.dart';
import 'package:hedwig_client/core/db/daos/mailbox_dao.dart';
import 'package:hedwig_client/core/db/daos/message_dao.dart';
import 'package:hedwig_client/core/db/daos/outbox_dao.dart';
import 'package:hedwig_client/core/db/daos/thread_dao.dart';
import 'package:hedwig_client/core/db/tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Mailboxes,
    Threads,
    Messages,
    Contacts,
    Labels,
    MessageLabelCache,
    MessageUserStates,
    SyncMeta,
    OutboxEntries,
  ],
  daos: [MailboxDao, ThreadDao, MessageDao, ContactDao, LabelDao, OutboxDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Builds the database over a caller-supplied executor (e.g. an in-memory
  /// `NativeDatabase.memory()`) for tests, bypassing the platform connection.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(threads, threads.folder);
      }
      if (from < 3) {
        await m.addColumn(messages, messages.attachmentsJson);
      }
      if (from < 4) {
        await m.addColumn(messages, messages.scheduledAt);
      }
      if (from < 5) {
        // Threads primary key changed to (id, folder). Recreate the cache
        // table; it is rebuilt from the network on next load.
        await m.deleteTable('threads');
        await m.createTable(threads);
      }
      if (from < 6) {
        await m.addColumn(mailboxes, mailboxes.quotaBytes);
        await m.addColumn(mailboxes, mailboxes.usedBytes);
        await m.addColumn(messages, messages.envelopeSender);
        await m.addColumn(messages, messages.envelopeRecipient);
        await m.addColumn(messages, messages.bccAddressesJson);
        await m.addColumn(messages, messages.replyTo);
        await m.addColumn(messages, messages.rawHeadersJson);
        await m.addColumn(messages, messages.metadataJson);
      }
      if (from < 7) {
        await m.addColumn(threads, threads.unreadCount);
        await m.addColumn(threads, threads.snippet);
        await m.addColumn(threads, threads.latestDirection);
        await m.addColumn(threads, threads.hasAttachments);
        await m.addColumn(threads, threads.attachmentFilenamesJson);
        await m.addColumn(threads, threads.labelsJson);
        await m.addColumn(threads, threads.searchHighlight);
      }
      if (from < 8) {
        await m.addColumn(messages, messages.rawMimeUrl);
      }
      if (from < 9) {
        await m.createTable(messageLabelCache);
        await m.createTable(messageUserStates);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'hedwig_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
