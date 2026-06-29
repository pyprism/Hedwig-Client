import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/threads/presentation/screens/thread_list_screen.dart';

void main() {
  group('threadListShortcuts', () {
    test('disables bare-key shortcuts while text input is focused', () {
      final shortcuts = threadListShortcuts(textInputFocused: true);

      expect(shortcuts, isEmpty);
    });

    test('enables archive shortcut when text input is not focused', () {
      final shortcuts = threadListShortcuts(textInputFocused: false);

      expect(
        shortcuts,
        containsPair(LogicalKeySet(LogicalKeyboardKey.keyE), isA<Intent>()),
      );
    });
  });
}
