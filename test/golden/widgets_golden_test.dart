import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';

/// Breakpoints mirror `docs/app_plan.md`: compact <600, medium <840,
/// expanded ≥840.
const _breakpoints = <String, Size>{
  'compact': Size(400, 720),
  'medium': Size(720, 720),
  'expanded': Size(1000, 720),
};

/// Mirrors `_buildTheme` in `lib/app/app.dart` so goldens reflect the real app.
ThemeData _theme(Brightness brightness) => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF1565C0),
    brightness: brightness,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);

void main() {
  final scenarios = <String, Widget>{
    'empty_state': const EmptyState(
      icon: Icons.inbox_outlined,
      title: 'No messages',
      subtitle: 'Your inbox is empty.',
    ),
    'error_display': const ErrorDisplay(
      failure: Failure.network(message: 'Check your connection and try again.'),
    ),
    'loading': const LoadingWidget(),
  };

  for (final brightness in Brightness.values) {
    final themeName = brightness == Brightness.light ? 'light' : 'dark';
    for (final scenario in scenarios.entries) {
      for (final bp in _breakpoints.entries) {
        testGoldens('${scenario.key} · $themeName · ${bp.key}', (tester) async {
          await tester.pumpWidgetBuilder(
            Scaffold(body: scenario.value),
            wrapper: materialAppWrapper(theme: _theme(brightness)),
            surfaceSize: bp.value,
          );
          await screenMatchesGolden(
            tester,
            '${scenario.key}_${themeName}_${bp.key}',
            // Avoid pumpAndSettle: LoadingWidget animates forever. A fixed
            // single-frame pump captures it deterministically.
            customPump: (t) => t.pump(const Duration(milliseconds: 50)),
          );
        });
      }
    }
  }
}
