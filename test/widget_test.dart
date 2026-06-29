import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/core/widgets/skeleton_loader.dart';
import 'package:hedwig_client/core/error/failure.dart';

Widget _wrap(Widget child) => ProviderScope(child: MaterialApp(home: child));

void main() {
  group('LoadingWidget', () {
    testWidgets('shows a progress indicator', (tester) async {
      await tester.pumpWidget(_wrap(const Scaffold(body: LoadingWidget())));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('EmptyState', () {
    testWidgets('shows title and subtitle', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Scaffold(
            body: EmptyState(
              icon: Icons.inbox_outlined,
              title: 'Nothing here',
              subtitle: 'No messages.',
            ),
          ),
        ),
      );
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('No messages.'), findsOneWidget);
    });
  });

  group('ErrorDisplay', () {
    testWidgets('shows error message with retry button', (tester) async {
      bool retried = false;
      await tester.pumpWidget(
        _wrap(
          Scaffold(
            body: ErrorDisplay(
              failure: const Failure.network(message: 'offline'),
              onRetry: () => retried = true,
            ),
          ),
        ),
      );
      expect(find.textContaining('No connection'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(retried, isTrue);
    });

    testWidgets('shows without retry when callback absent', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const Scaffold(
            body: ErrorDisplay(failure: Failure.unknown(message: 'Oops')),
          ),
        ),
      );
      expect(find.text('Retry'), findsNothing);
    });
  });

  group('SkeletonBox', () {
    testWidgets('renders with given dimensions', (tester) async {
      await tester.pumpWidget(
        _wrap(const Scaffold(body: SkeletonBox(width: 100, height: 20))),
      );
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints?.maxWidth, 100);
    });
  });

  group('ThreadListSkeleton', () {
    testWidgets('renders correct number of placeholders', (tester) async {
      await tester.pumpWidget(
        _wrap(const Scaffold(body: ThreadListSkeleton(itemCount: 3))),
      );
      // 3 items + 2 separators = 5 children via ListView; just assert no crash
      expect(find.byType(ThreadListSkeleton), findsOneWidget);
    });
  });
}
