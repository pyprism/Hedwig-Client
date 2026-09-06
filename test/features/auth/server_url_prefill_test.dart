import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:hedwig_client/core/storage/secure_storage.dart';
import 'package:hedwig_client/features/auth/presentation/screens/login_screen.dart';
import 'package:hedwig_client/features/auth/presentation/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_secure_storage.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester, Widget screen) async {
    SharedPreferences.setMockInitialValues({
      'base_url': 'https://saved.example.test',
    });
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefsStorageProvider.overrideWithValue(prefs),
          secureStorageProvider.overrideWithValue(fakeSecureStorage()),
        ],
        child: MaterialApp(home: screen),
      ),
    );
    await tester.pump();
  }

  String serverFieldValue(WidgetTester tester) {
    final field = tester.widget<TextFormField>(
      find.widgetWithText(TextFormField, 'Server URL'),
    );
    return field.controller!.text;
  }

  testWidgets('login pre-fills the persisted server URL', (tester) async {
    await pumpScreen(tester, const LoginScreen());

    expect(serverFieldValue(tester), 'https://saved.example.test');
  });

  testWidgets('registration pre-fills the persisted server URL', (
    tester,
  ) async {
    await pumpScreen(tester, const RegisterScreen());

    expect(serverFieldValue(tester), 'https://saved.example.test');
  });
}
