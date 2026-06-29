import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/db/app_database.dart';

/// Guards the Phase 2.5 web persistence contract: drift on web runs on a
/// sqlite3 wasm build + a worker, backed by IndexedDB so the cache survives a
/// hard refresh. A true in-browser reload test needs `integration_test` +
/// chromedriver; these guards catch the common regressions (assets dropped,
/// web options unwired, schema not surviving a reopen) without a browser.
void main() {
  group('drift web persistence config', () {
    test('wasm + worker assets are bundled in web/', () {
      expect(
        File('web/sqlite3.wasm').existsSync(),
        isTrue,
        reason: 'sqlite3.wasm must be bundled for drift on web',
      );
      expect(
        File('web/drift_worker.js').existsSync(),
        isTrue,
        reason: 'drift_worker.js must be bundled for drift on web',
      );
    });

    test('AppDatabase wires DriftWebOptions to the bundled wasm + worker', () {
      final src = File('lib/core/db/app_database.dart').readAsStringSync();
      expect(src, contains('DriftWebOptions'));
      expect(src, contains("sqlite3Wasm: Uri.parse('sqlite3.wasm')"));
      expect(src, contains("driftWorker: Uri.parse('drift_worker.js')"));
    });

    test('cache survives a reopen of the same database (reload proxy)', () async {
      final dir = Directory.systemTemp.createTempSync('hedwig_db_test');
      final file = File('${dir.path}/hedwig.sqlite');
      addTearDown(() => dir.deleteSync(recursive: true));

      var db = AppDatabase.forTesting(NativeDatabase(file));
      await db.mailboxDao.upsertAll([
        MailboxesCompanion.insert(
          id: 'mb1',
          domainId: 'd1',
          localPart: 'support',
          emailAddress: 'support@acme.com',
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);
      await db.close();

      // Reopen the same on-disk database — mirrors a web hard refresh where the
      // IndexedDB-backed store is reloaded into a fresh AppDatabase instance.
      db = AppDatabase.forTesting(NativeDatabase(file));
      addTearDown(db.close);
      final rows = await db.mailboxDao.getAll();
      expect(rows.map((r) => r.id), contains('mb1'));
    });
  });
}
