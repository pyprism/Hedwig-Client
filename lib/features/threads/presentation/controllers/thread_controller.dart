import 'package:hedwig_client/features/threads/data/repositories/thread_repository.dart';
import 'package:hedwig_client/shared/models/thread.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_controller.g.dart';

@riverpod
Stream<List<MailThread>> threadList(
  Ref ref, {
  required String mailboxId,
  String folder = 'inbox',
  String? search,
}) {
  return ref
      .watch(threadRepositoryProvider)
      .watchThreads(mailboxId: mailboxId, folder: folder, search: search);
}

/// Selected thread for two-pane layout on expanded screens.
@Riverpod(keepAlive: true)
class SelectedThread extends _$SelectedThread {
  @override
  String? build() => null;

  void select(String threadId) => state = threadId;
  void clear() => state = null;
}
