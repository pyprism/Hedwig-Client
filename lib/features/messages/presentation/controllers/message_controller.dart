import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_controller.g.dart';

@riverpod
Stream<List<MailMessage>> threadMessages(Ref ref, String threadId) {
  return ref.watch(messageRepositoryProvider).watchThread(threadId);
}

@riverpod
class MessageStateController extends _$MessageStateController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> markRead(String id, {required bool isRead}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(messageRepositoryProvider).updateState(id, isRead: isRead),
    );
  }

  Future<void> toggleStar(String id, {required bool starred}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(messageRepositoryProvider)
          .updateState(id, isStarred: starred),
    );
  }

  Future<void> moveToFolder(String id, String folder) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(messageRepositoryProvider).updateState(id, folder: folder),
    );
  }

  Future<void> snooze(String id, DateTime until) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(messageRepositoryProvider)
          .updateState(id, snoozedUntil: until),
    );
  }

  Future<void> cancelScheduledSend(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(messageRepositoryProvider).cancelScheduledSend(id),
    );
  }
}
