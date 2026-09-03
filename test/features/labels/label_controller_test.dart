import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/labels/data/repositories/label_repository.dart';
import 'package:hedwig_client/features/labels/presentation/controllers/label_controller.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:mocktail/mocktail.dart';

class _MockLabelRepository extends Mock implements LabelRepository {}

void main() {
  late _MockLabelRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = _MockLabelRepository();
    container = ProviderContainer(
      overrides: [labelRepositoryProvider.overrideWithValue(repo)],
    );
  });

  tearDown(() => container.dispose());

  group('labelList', () {
    test('streams from LabelRepository.watchLabels', () async {
      when(() => repo.watchLabels('mb1')).thenAnswer(
        (_) => Stream.value(const [
          Label(id: 'l1', mailboxId: 'mb1', name: 'Work'),
        ]),
      );
      final provider = labelListProvider('mb1');
      final sub = container.listen(provider, (_, _) {});
      addTearDown(sub.close);

      final labels = await container.read(provider.future);

      expect(labels.single.id, 'l1');
    });
  });

  group('LabelActions', () {
    test('create delegates to the repository and settles to data', () async {
      when(() => repo.create(mailboxId: 'mb1', name: 'New', color: null))
          .thenAnswer(
            (_) async => const Label(id: 'l1', mailboxId: 'mb1', name: 'New'),
          );

      await container
          .read(labelActionsProvider.notifier)
          .create(mailboxId: 'mb1', name: 'New');

      expect(container.read(labelActionsProvider).hasError, isFalse);
      verify(() => repo.create(mailboxId: 'mb1', name: 'New', color: null))
          .called(1);
    });

    test('delete surfaces a repository failure as AsyncError', () async {
      when(() => repo.delete('l1')).thenThrow(Exception('boom'));

      await container.read(labelActionsProvider.notifier).delete('l1');

      expect(container.read(labelActionsProvider).hasError, isTrue);
    });

    test('applyToMessage delegates to the repository', () async {
      when(() => repo.applyToMessage(messageId: 'm1', labelId: 'l1'))
          .thenAnswer((_) async {});

      await container
          .read(labelActionsProvider.notifier)
          .applyToMessage(messageId: 'm1', labelId: 'l1');

      verify(() => repo.applyToMessage(messageId: 'm1', labelId: 'l1'))
          .called(1);
    });

    test('removeFromMessage delegates to the repository', () async {
      when(() => repo.removeFromMessage(messageId: 'm1', labelId: 'l1'))
          .thenAnswer((_) async {});

      await container
          .read(labelActionsProvider.notifier)
          .removeFromMessage(messageId: 'm1', labelId: 'l1');

      verify(() => repo.removeFromMessage(messageId: 'm1', labelId: 'l1'))
          .called(1);
    });
  });
}
