import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

/// Global test bootstrap. Ensures the test binding is initialized before any
/// test runs so code touching platform channels (e.g. connectivity) doesn't
/// trip "Binding has not yet been initialized".
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await testMain();
}
