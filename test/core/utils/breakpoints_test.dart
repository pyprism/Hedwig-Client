import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/utils/breakpoints.dart';

void main() {
  group('resolveFormFactor', () {
    test('classifies compact widths below 600', () {
      expect(resolveFormFactor(0), FormFactor.compact);
      expect(resolveFormFactor(599.99), FormFactor.compact);
    });

    test('classifies medium widths from 600 up to below 840', () {
      expect(resolveFormFactor(Breakpoints.compact), FormFactor.medium);
      expect(resolveFormFactor(839.99), FormFactor.medium);
    });

    test('classifies expanded widths from 840 and above', () {
      expect(resolveFormFactor(Breakpoints.medium), FormFactor.expanded);
      expect(resolveFormFactor(1200), FormFactor.expanded);
    });
  });

  group('FormFactorContext', () {
    testWidgets('exposes compact context helpers', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(500, 800)),
          child: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedContext.formFactor, FormFactor.compact);
      expect(capturedContext.isCompact, isTrue);
      expect(capturedContext.isWide, isFalse);
    });

    testWidgets('exposes expanded context helpers', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1000, 800)),
          child: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedContext.formFactor, FormFactor.expanded);
      expect(capturedContext.isExpanded, isTrue);
      expect(capturedContext.isWide, isTrue);
    });
  });
}
