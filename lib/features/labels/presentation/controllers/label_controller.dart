import 'package:hedwig_client/features/labels/data/repositories/label_repository.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'label_controller.g.dart';

@riverpod
Stream<List<Label>> labelList(Ref ref, String mailboxId) {
  return ref.watch(labelRepositoryProvider).watchLabels(mailboxId);
}

@riverpod
class LabelActions extends _$LabelActions {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> create({
    required String mailboxId,
    required String name,
    String? color,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(labelRepositoryProvider)
          .create(mailboxId: mailboxId, name: name, color: color),
    );
  }

  Future<void> delete(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(labelRepositoryProvider).delete(id),
    );
  }

  Future<void> applyToMessage({
    required String messageId,
    required String labelId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(labelRepositoryProvider)
          .applyToMessage(messageId: messageId, labelId: labelId),
    );
  }

  Future<void> removeFromMessage({
    required String messageId,
    required String labelId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(labelRepositoryProvider)
          .removeFromMessage(messageId: messageId, labelId: labelId),
    );
  }
}
