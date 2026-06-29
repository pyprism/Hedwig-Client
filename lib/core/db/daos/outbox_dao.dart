import 'package:drift/drift.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/db/tables.dart';

part 'outbox_dao.g.dart';

@DriftAccessor(tables: [OutboxEntries])
class OutboxDao extends DatabaseAccessor<AppDatabase> with _$OutboxDaoMixin {
  OutboxDao(super.db);

  Stream<int> watchPendingCount() => customSelect(
    "SELECT COUNT(*) AS c FROM outbox_entries WHERE status IN ('pending','failed')",
    readsFrom: {outboxEntries},
  ).watchSingle().map((row) => row.read<int>('c'));

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

  Future<void> markSending(int id) =>
      (update(outboxEntries)..where((e) => e.id.equals(id))).write(
        OutboxEntriesCompanion(
          status: const Value('sending'),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );

  Future<void> markDone(int id) =>
      (delete(outboxEntries)..where((e) => e.id.equals(id))).go();

  Future<void> markFailed(int id, String error, int retryCount) =>
      (update(outboxEntries)..where((e) => e.id.equals(id))).write(
        OutboxEntriesCompanion(
          status: const Value('failed'),
          lastError: Value(error),
          retryCount: Value(retryCount),
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

  Stream<int> watchDeadLetterCount() => customSelect(
    "SELECT COUNT(*) AS c FROM outbox_entries WHERE status = 'dead_letter'",
    readsFrom: {outboxEntries},
  ).watchSingle().map((row) => row.read<int>('c'));

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
