import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/mailboxes/data/repositories/mailbox_repository.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';
import 'package:mocktail/mocktail.dart';

class _MockMailboxRepository extends Mock implements MailboxRepository {}

void main() {
  group('SelectedMailbox', () {
    late ProviderContainer container;

    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('starts unselected', () {
      expect(container.read(selectedMailboxProvider), isNull);
    });

    test('select stores the mailbox id', () {
      container.read(selectedMailboxProvider.notifier).select('mb1');

      expect(container.read(selectedMailboxProvider), 'mb1');
    });
  });

  group('SelectedFolder', () {
    late ProviderContainer container;

    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('defaults to inbox', () {
      expect(container.read(selectedFolderProvider), 'inbox');
    });

    test('select switches folders', () {
      container.read(selectedFolderProvider.notifier).select('archive');

      expect(container.read(selectedFolderProvider), 'archive');
    });
  });

  group('mailboxList', () {
    test('streams from MailboxRepository.watchMailboxes', () async {
      final repo = _MockMailboxRepository();
      when(() => repo.watchMailboxes()).thenAnswer(
        (_) => Stream.value(const [
          Mailbox(
            id: 'mb1',
            domainId: 'domain1',
            localPart: 'support',
            emailAddress: 'support@example.test',
          ),
        ]),
      );
      final container = ProviderContainer(
        overrides: [mailboxRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      final sub = container.listen(mailboxListProvider, (_, _) {});
      addTearDown(sub.close);

      final mailboxes = await container.read(mailboxListProvider.future);

      expect(mailboxes.single.id, 'mb1');
    });
  });
}
