import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/message_controller.dart';
import 'package:mocktail/mocktail.dart';

class _MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  late _MockMessageRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = _MockMessageRepository();
    container = ProviderContainer(
      overrides: [messageRepositoryProvider.overrideWithValue(repo)],
    );
  });

  tearDown(() => container.dispose());

  group('MessageStateController', () {
    test(
      'markRead calls repository.updateState with isRead and settles to data',
      () async {
        when(() => repo.updateState('m1', isRead: true))
            .thenAnswer((_) async {});

        await container
            .read(messageStateControllerProvider.notifier)
            .markRead('m1', isRead: true);

        verify(() => repo.updateState('m1', isRead: true)).called(1);
        expect(
          container.read(messageStateControllerProvider).hasError,
          isFalse,
        );
        expect(
          container.read(messageStateControllerProvider).isLoading,
          isFalse,
        );
      },
    );

    test('toggleStar surfaces a repository failure as AsyncError', () async {
      when(() => repo.updateState('m1', isStarred: true))
          .thenThrow(Exception('boom'));

      await container
          .read(messageStateControllerProvider.notifier)
          .toggleStar('m1', starred: true);

      expect(container.read(messageStateControllerProvider).hasError, isTrue);
    });

    test('moveToFolder delegates to repository.updateState(folder:)', () async {
      when(() => repo.updateState('m1', folder: 'archive'))
          .thenAnswer((_) async {});

      await container
          .read(messageStateControllerProvider.notifier)
          .moveToFolder('m1', 'archive');

      verify(() => repo.updateState('m1', folder: 'archive')).called(1);
    });

    test('snooze delegates to repository.updateState(snoozedUntil:)', () async {
      final until = DateTime.utc(2026, 1, 1);
      when(() => repo.updateState('m1', snoozedUntil: until))
          .thenAnswer((_) async {});

      await container
          .read(messageStateControllerProvider.notifier)
          .snooze('m1', until);

      verify(() => repo.updateState('m1', snoozedUntil: until)).called(1);
    });

    test(
      'cancelScheduledSend delegates to repository.cancelScheduledSend',
      () async {
        when(() => repo.cancelScheduledSend('m1')).thenAnswer((_) async {});

        await container
            .read(messageStateControllerProvider.notifier)
            .cancelScheduledSend('m1');

        verify(() => repo.cancelScheduledSend('m1')).called(1);
      },
    );
  });
}
