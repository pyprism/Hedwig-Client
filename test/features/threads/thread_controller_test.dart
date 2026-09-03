import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/threads/data/repositories/thread_repository.dart';
import 'package:hedwig_client/features/threads/presentation/controllers/thread_controller.dart';
import 'package:hedwig_client/shared/models/thread.dart';
import 'package:mocktail/mocktail.dart';

class _MockThreadRepository extends Mock implements ThreadRepository {}

void main() {
  group('SelectedThread', () {
    late ProviderContainer container;

    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('starts unselected', () {
      expect(container.read(selectedThreadProvider), isNull);
    });

    test('select stores the thread id', () {
      container.read(selectedThreadProvider.notifier).select('t1');

      expect(container.read(selectedThreadProvider), 't1');
    });

    test('clear resets to null', () {
      container.read(selectedThreadProvider.notifier).select('t1');

      container.read(selectedThreadProvider.notifier).clear();

      expect(container.read(selectedThreadProvider), isNull);
    });
  });

  group('threadList', () {
    test(
      'streams from ThreadRepository.watchThreads with the given args',
      () async {
        final repo = _MockThreadRepository();
        when(
          () => repo.watchThreads(
            mailboxId: 'mb1',
            folder: 'inbox',
            search: null,
          ),
        ).thenAnswer(
          (_) => Stream.value(const [
            MailThread(id: 't1', mailboxId: 'mb1', subject: 'Hi'),
          ]),
        );
        final container = ProviderContainer(
          overrides: [threadRepositoryProvider.overrideWithValue(repo)],
        );
        addTearDown(container.dispose);
        final provider = threadListProvider(mailboxId: 'mb1');
        // Autodispose family provider: hold a subscription so it survives long
        // enough for the stream's first value to resolve.
        final sub = container.listen(provider, (_, _) {});
        addTearDown(sub.close);

        final threads = await container.read(provider.future);

        expect(threads.single.id, 't1');
      },
    );
  });
}
