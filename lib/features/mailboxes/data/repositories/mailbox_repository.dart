import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/mailboxes/data/datasources/mailbox_remote_datasource.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mailbox_repository.g.dart';

@Riverpod(keepAlive: true)
MailboxRepository mailboxRepository(Ref ref) {
  return MailboxRepository(ref: ref, db: ref.watch(appDatabaseProvider));
}

class MailboxRepository {
  const MailboxRepository({required this.ref, required this.db});

  static const _liveRefreshInterval = Duration(seconds: 20);

  final Ref ref;
  final AppDatabase db;

  MailboxRemoteDatasource get remote =>
      MailboxRemoteDatasource(ref.read(dioClientProvider));

  Stream<List<Mailbox>> watchMailboxes() {
    final cached = db.mailboxDao.watchAll().map(
      (rows) => rows.map(_rowToModel).toList(),
    );

    return Stream.multi((controller) {
      Timer? timer;
      StreamSubscription<List<Mailbox>>? subscription;
      var cancelled = false;
      var refreshing = false;
      // True once a refresh has actually returned a result. Until then an empty
      // drift table means "not loaded yet", not "no mailboxes" — suppress it so
      // a slow/failed first fetch doesn't surface as the "No mailboxes" state.
      var loadedFromRemote = false;

      Future<void> refresh({required bool surfaceError}) async {
        if (refreshing) return;
        refreshing = true;
        try {
          await _refresh();
          loadedFromRemote = true;
        } catch (e) {
          debugPrint('[MailboxRepository] refresh error: $e');
          if (surfaceError && !cancelled) {
            controller.addError(e);
          }
        } finally {
          refreshing = false;
        }
      }

      Future<void> start() async {
        final existing = await db.mailboxDao.getAll();
        if (existing.isEmpty) {
          // Empty cache: wait for the network so a stalled/failed request does
          // not look like a valid "No mailboxes" state.
          await refresh(surfaceError: true);
        } else {
          unawaited(refresh(surfaceError: false));
        }
        if (cancelled) return;

        subscription = cached.listen(
          (mailboxes) {
            // Don't let a pre-load empty table render as "No mailboxes".
            if (mailboxes.isEmpty && !loadedFromRemote) return;
            controller.add(mailboxes);
          },
          onError: controller.addError,
          onDone: controller.close,
        );
        timer = Timer.periodic(
          _liveRefreshInterval,
          (_) => unawaited(refresh(surfaceError: false)),
        );
      }

      unawaited(
        start().catchError((Object e) {
          if (!cancelled) controller.addError(e);
        }),
      );

      controller.onCancel = () async {
        cancelled = true;
        timer?.cancel();
        await subscription?.cancel();
      };
    });
  }

  Future<void> _refresh() async {
    final mailboxes = await remote.getMailboxes();
    final companions = mailboxes.map(_modelToRow).toList();

    await db.transaction(() async {
      await db.mailboxDao.deleteAll();
      if (companions.isNotEmpty) {
        await db.mailboxDao.upsertAll(companions);
      }
    });
  }

  Mailbox _rowToModel(MailboxRow r) => Mailbox(
    id: r.id,
    domainId: r.domainId,
    localPart: r.localPart,
    emailAddress: r.emailAddress,
    displayName: r.displayName,
    sendEnabled: r.sendEnabled,
    receiveEnabled: r.receiveEnabled,
    isActive: r.isActive,
    quotaBytes: r.quotaBytes,
    usedBytes: r.usedBytes,
    signatureHtml: r.signatureHtml,
    signatureText: r.signatureText,
    updatedAt: r.updatedAt,
  );

  MailboxesCompanion _modelToRow(Mailbox m) => MailboxesCompanion.insert(
    id: m.id,
    domainId: m.domainId,
    localPart: m.localPart,
    emailAddress: m.emailAddress,
    displayName: Value(m.displayName),
    sendEnabled: Value(m.sendEnabled),
    receiveEnabled: Value(m.receiveEnabled),
    isActive: Value(m.isActive),
    quotaBytes: Value(m.quotaBytes),
    usedBytes: Value(m.usedBytes),
    signatureHtml: Value(m.signatureHtml),
    signatureText: Value(m.signatureText),
    updatedAt: m.updatedAt ?? DateTime.now().toUtc(),
  );
}
