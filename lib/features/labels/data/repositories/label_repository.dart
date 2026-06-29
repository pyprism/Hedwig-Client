import 'package:drift/drift.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/labels/data/datasources/label_remote_datasource.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'label_repository.g.dart';

@Riverpod(keepAlive: true)
LabelRepository labelRepository(Ref ref) {
  return LabelRepository(
    remote: LabelRemoteDatasource(ref.watch(dioClientProvider)),
    db: ref.watch(appDatabaseProvider),
  );
}

class LabelRepository {
  const LabelRepository({required this.remote, required this.db});

  final LabelRemoteDatasource remote;
  final AppDatabase db;

  Stream<List<Label>> watchLabels(String mailboxId) {
    _refresh(mailboxId);
    return db.labelDao
        .watchByMailbox(mailboxId)
        .map((rows) => rows.map(_rowToModel).toList());
  }

  Future<void> _refresh(String mailboxId) async {
    try {
      final labels = await remote.getLabels(mailboxId: mailboxId);
      await db.labelDao.upsertAll(labels.map(_modelToRow).toList());
    } catch (_) {}
  }

  Future<Label> create({
    required String mailboxId,
    required String name,
    String? color,
  }) async {
    final label = await remote.createLabel(
      mailboxId: mailboxId,
      name: name,
      color: color,
    );
    await db.labelDao.upsertAll([_modelToRow(label)]);
    return label;
  }

  Future<void> delete(String id) async {
    await remote.deleteLabel(id);
    await db.labelDao.deleteLabel(id);
  }

  Future<void> applyToMessage({
    required String messageId,
    required String labelId,
  }) async {
    await remote.applyLabel(messageId: messageId, labelId: labelId);
    await db
        .into(db.messageLabelCache)
        .insertOnConflictUpdate(
          MessageLabelCacheCompanion.insert(
            messageId: messageId,
            labelId: labelId,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> removeFromMessage({
    required String messageId,
    required String labelId,
  }) async {
    await remote.removeLabel(messageId: messageId, labelId: labelId);
    await (db.delete(db.messageLabelCache)..where(
          (row) =>
              row.messageId.equals(messageId) & row.labelId.equals(labelId),
        ))
        .go();
  }

  Future<List<String>> getMessageLabelIds(String messageId) async {
    try {
      final ids = await remote.getMessageLabelIds(messageId);
      await db.transaction(() async {
        await (db.delete(
          db.messageLabelCache,
        )..where((row) => row.messageId.equals(messageId))).go();
        await db.batch((batch) {
          batch.insertAllOnConflictUpdate(
            db.messageLabelCache,
            ids
                .map(
                  (id) => MessageLabelCacheCompanion.insert(
                    messageId: messageId,
                    labelId: id,
                    updatedAt: DateTime.now().toUtc(),
                  ),
                )
                .toList(),
          );
        });
      });
      return ids;
    } catch (_) {
      final cached = await (db.select(
        db.messageLabelCache,
      )..where((row) => row.messageId.equals(messageId))).get();
      return cached.map((row) => row.labelId).toList();
    }
  }

  Label _rowToModel(LabelRow r) => Label(
    id: r.id,
    mailboxId: r.mailboxId,
    name: r.name,
    color: r.color,
    createdAt: r.createdAt,
  );

  LabelsCompanion _modelToRow(Label l) => LabelsCompanion.insert(
    id: l.id,
    mailboxId: l.mailboxId,
    name: l.name,
    color: Value(l.color),
    createdAt: l.createdAt ?? DateTime.now().toUtc(),
  );
}
