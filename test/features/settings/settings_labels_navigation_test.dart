import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/storage/prefs_storage.dart';
import 'package:hedwig_client/features/auth/domain/entities/auth_state.dart';
import 'package:hedwig_client/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hedwig_client/features/labels/presentation/controllers/label_controller.dart';
import 'package:hedwig_client/features/labels/presentation/screens/labels_screen.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/features/settings/presentation/screens/settings_screen.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AuthControllerOverride extends AuthController {
  @override
  Future<AuthState> build() async => const AuthState.unauthenticated();
}

void main() {
  testWidgets('settings labels tile opens labels screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final router = GoRouter(
      initialLocation: '/settings',
      routes: [
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/labels',
          builder: (context, state) => const LabelsScreen(),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          prefsStorageProvider.overrideWithValue(prefs),
          authControllerProvider.overrideWith(_AuthControllerOverride.new),
          mailboxListProvider.overrideWith(
            (ref) => Stream.value(const [
              Mailbox(
                id: 'mb1',
                domainId: 'domain1',
                localPart: 'support',
                emailAddress: 'support@example.com',
              ),
            ]),
          ),
          labelListProvider('mb1').overrideWith(
            (ref) => Stream.value(const [
              Label(
                id: 'lbl1',
                mailboxId: 'mb1',
                name: 'Support',
                color: '#2196F3',
              ),
            ]),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Labels'));
    await tester.pumpAndSettle();

    expect(find.byType(LabelsScreen), findsOneWidget);
    expect(find.text('Support'), findsOneWidget);
  });
}
