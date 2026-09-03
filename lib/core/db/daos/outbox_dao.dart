import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'outbox_dao.g.dart';

@DriftAccessor(tables: [OutboxEntries])
class OutboxDao extends DatabaseAccessor<AppDatabase> with _$OutboxDaoMixin {
  OutboxDao(super.db);

  Stream<int> watchPendingCount() {
    final count = outboxEntries.id.count();
    final query = selectOnly(outboxEntries)
      ..addColumns([count])
      ..where(outboxEntries.status.isIn(['pending', 'failed']));
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Stream<List<OutboxEntry>> watchPending() =>
      (select(outboxEntries)
            ..where((e) => e.status.isIn(['pending', 'failed']))
            ..orderBy([(e) => OrderingTerm.asc(e.createdAt)]))
          .watch();

  Future<List<OutboxEntry>> getPending() =>
      (select(outboxEntries)
            ..where((e) => e.status.isIn(['pending', 'failed']))
            ..orderBy([(e) => OrderingTerm.asc(e.createdAt)]))
          .get();

  Future<int> enqueue({
    required String operation,
    required String payloadJson,
  }) => into(outboxEntries).insert(
    OutboxEntriesCompanion.insert(
      operation: operation,
      payloadJson: payloadJson,
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    ),
  );

  /// Overwrites a still-queued entry's payload, resetting it to a fresh
  /// pending state. Used to coalesce repeated draft saves into one outbox op
  /// so rapid re-saves don't create duplicate server drafts.
  Future<void> updatePayload(int id, String payloadJson) =>
      (update(outboxEntries)..where((e) => e.id.equals(id))).write(
        OutboxEntriesCompanion(
          payloadJson: Value(payloadJson),
          status: const Value('pending'),
          retryCount: const Value(0),
          lastError: const Value(null),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  /// Rewinds any entry left in `sending` back to `pending`. `sending` is only
  /// ever set right before a dispatch and cleared right after — a row still in
  /// that state on startup means the app died mid-dispatch, so it must be
  /// retried rather than left stuck forever (nothing else re-queues it).
  Future<void> resetStuckSending() =>
      (update(outboxEntries)..where((e) => e.status.equals('sending'))).write(
        OutboxEntriesCompanion(
          status: const Value('pending'),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Future<void> markSending(int id) =>
      (update(outboxEntries)..where((e) => e.id.equals(id))).write(
        OutboxEntriesCompanion(
          status: const Value('sending'),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Future<void> markDone(int id) =>
      (delete(outboxEntries)..where((e) => e.id.equals(id))).go();

  Future<void> markFailed(
    int id,
    String error,
    int retryCount, {
    DateTime? retryAfterUntil,
  }) => (update(outboxEntries)..where((e) => e.id.equals(id))).write(
    OutboxEntriesCompanion(
      status: const Value('failed'),
      lastError: Value(error),
      retryCount: Value(retryCount),
      // Always overwritten (not left stale): a retry-after from a previous
      // 429 must not keep gating retries once a later failure was for some
      // other reason.
      retryAfterUntil: Value(retryAfterUntil),
      updatedAt: Value(DateTime.now().toUtc()),
    ),
  );

  /// Entries that exhausted their retry budget. Excluded from [getPending]/
  /// [watchPending] so the sync engine stops touching them; surfaced to the
  /// user instead via [watchDeadLetterCount]/[watchDeadLetter].
  Future<void> markDeadLetter(int id) =>
      (update(outboxEntries)..where((e) => e.id.equals(id))).write(
        OutboxEntriesCompanion(
          status: const Value('dead_letter'),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Stream<int> watchDeadLetterCount() {
    final count = outboxEntries.id.count();
    final query = selectOnly(outboxEntries)
      ..addColumns([count])
      ..where(outboxEntries.status.equals('dead_letter'));
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Stream<List<OutboxEntry>> watchDeadLetter() =>
      (select(outboxEntries)
            ..where((e) => e.status.equals('dead_letter'))
            ..orderBy([(e) => OrderingTerm.asc(e.createdAt)]))
          .watch();

  /// Puts an entry back into the retry queue from dead-letter state.
  Future<void> retry(int id) =>
      (update(outboxEntries)..where((e) => e.id.equals(id))).write(
        OutboxEntriesCompanion(
          status: const Value('pending'),
          retryCount: const Value(0),
          lastError: const Value(null),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Future<void> discard(int id) =>
      (delete(outboxEntries)..where((e) => e.id.equals(id))).go();
}
