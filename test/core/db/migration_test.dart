import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;

// AppDatabase.forTesting always opens a fresh in-memory DB, which runs
// onCreate (createAll()) — every other test in this suite exercises that
// path, never onUpgrade. This test builds a hand-rolled schema-v9 database
// (the shape before isImportant/retryAfterUntil existed) and opens the real
// AppDatabase on top of it, forcing the from<10/from<11 onUpgrade branches
// in app_database.dart to actually run.
void main() {
  test(
    'migrating from schema v9 adds isImportant and retryAfterUntil without error',
    () async {
      final raw = sqlite3.sqlite3.openInMemory();
      raw.execute('''
      CREATE TABLE messages (
        id TEXT NOT NULL PRIMARY KEY,
        mailbox_id TEXT NOT NULL,
        thread_id TEXT,
        direction TEXT NOT NULL,
        status TEXT NOT NULL,
        folder TEXT NOT NULL DEFAULT 'inbox',
        from_address TEXT NOT NULL,
        from_name TEXT,
        envelope_sender TEXT,
        envelope_recipient TEXT,
        to_addresses_json TEXT NOT NULL DEFAULT '[]',
        cc_addresses_json TEXT NOT NULL DEFAULT '[]',
        bcc_addresses_json TEXT NOT NULL DEFAULT '[]',
        reply_to TEXT,
        subject TEXT NOT NULL,
        snippet TEXT,
        body_text TEXT,
        body_html TEXT,
        raw_mime_url TEXT,
        is_read INTEGER NOT NULL DEFAULT 0,
        is_starred INTEGER NOT NULL DEFAULT 0,
        has_attachments INTEGER NOT NULL DEFAULT 0,
        attachments_json TEXT NOT NULL DEFAULT '[]',
        raw_headers_json TEXT NOT NULL DEFAULT '{}',
        metadata_json TEXT NOT NULL DEFAULT '{}',
        received_at INTEGER,
        sent_at INTEGER,
        scheduled_at INTEGER,
        created_at INTEGER NOT NULL
      );
    ''');
      raw.execute('''
      CREATE TABLE outbox_entries (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        operation TEXT NOT NULL,
        payload_json TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending',
        retry_count INTEGER NOT NULL DEFAULT 0,
        last_error TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      );
    ''');
      // Seed a row in each so we can assert the new columns' default values,
      // not just that the ALTER TABLE didn't throw.
      raw.execute('''
      INSERT INTO messages (id, mailbox_id, direction, status, from_address, subject, created_at)
      VALUES ('m1', 'mb1', 'inbound', 'delivered', 'a@example.com', 'Hi', 0);
    ''');
      raw.execute('''
      INSERT INTO outbox_entries (operation, payload_json, created_at, updated_at)
      VALUES ('send_message', '{}', 0, 0);
    ''');
      raw.execute('PRAGMA user_version = 9;');

      final db = AppDatabase.forTesting(NativeDatabase.opened(raw));
      addTearDown(db.close);

      final message = await (db.select(
        db.messages,
      )..where((m) => m.id.equals('m1'))).getSingle();
      expect(message.isImportant, isFalse);
      // Confirm the ALTER TABLE actually backfilled a real 0, not a NULL that
      // drift's mapper happens to coerce to false — a NULL here would mean
      // pre-existing installs get a non-nullable field backed by NULL.
      final rawValue = raw
          .select("SELECT is_important FROM messages WHERE id = 'm1'")
          .single;
      expect(rawValue['is_important'], 0);

      final entry = await db.select(db.outboxEntries).getSingle();
      expect(entry.retryAfterUntil == null, isTrue);
    },
  );
}
