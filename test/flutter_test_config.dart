import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

/// Global test bootstrap. Loads real fonts so golden text isn't rendered as
/// Ahem boxes, and only asserts goldens on the platform they were generated on
/// (macOS) — font hinting/anti-aliasing differs per OS, so CI on Linux would
/// otherwise false-fail. Non-golden tests are unaffected.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}
