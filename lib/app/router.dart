import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_access_screen.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_delivery_screen.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_domains_screen.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_mailboxes_screen.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_providers_screen.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_screen.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_users_screen.dart';
import 'package:hedwig_client/features/auth/domain/entities/auth_state.dart';
import 'package:hedwig_client/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hedwig_client/features/auth/presentation/screens/change_password_screen.dart';
import 'package:hedwig_client/features/auth/presentation/screens/login_screen.dart';
import 'package:hedwig_client/features/auth/presentation/screens/register_screen.dart';
import 'package:hedwig_client/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:hedwig_client/features/labels/presentation/screens/labels_screen.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/features/mailboxes/presentation/screens/shell_screen.dart';
import 'package:hedwig_client/features/messages/presentation/screens/compose_screen.dart';
import 'package:hedwig_client/features/messages/presentation/screens/thread_detail_screen.dart';
import 'package:hedwig_client/features/settings/presentation/screens/rules_screen.dart';
import 'package:hedwig_client/features/settings/presentation/screens/settings_screen.dart';
import 'package:hedwig_client/features/threads/presentation/screens/adaptive_mailbox_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

class _InboxRoute extends ConsumerWidget {
  const _InboxRoute();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mailboxId = ref.watch(selectedMailboxProvider);
    if (mailboxId != null) return AdaptiveMailboxView(mailboxId: mailboxId);

    // No mailbox selected yet — fall back to first available mailbox.
    return ref
        .watch(mailboxListProvider)
        .when(
          loading: () => const Scaffold(body: LoadingWidget()),
          error: (e, st) => Scaffold(
            body: EmptyState(
              icon: Icons.error_outline,
              title: 'Could not load mailboxes',
              subtitle: 'Pull to refresh or check your connection.',
              action: TextButton(
                onPressed: () => ref.invalidate(mailboxListProvider),
                child: const Text('Retry'),
              ),
            ),
          ),
          data: (mailboxes) {
            if (mailboxes.isEmpty) {
              return const Scaffold(
                body: EmptyState(
                  icon: Icons.inbox_outlined,
                  title: 'No mailboxes',
                  subtitle: 'Your account has no mailboxes yet.',
                ),
              );
            }
            return AdaptiveMailboxView(mailboxId: mailboxes.first.id);
          },
        );
  }
}

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/inbox',
    redirect: (context, state) {
      final auth = authState.valueOrNull;
      final loading = authState.isLoading;
      final loc = state.matchedLocation;

      if (loading) return null;

      if (auth == null || auth is Unauthenticated) {
        if (loc == '/login' || loc == '/register') return null;
        return '/login';
      }

      if (auth is MustChangePassword) {
        if (loc == '/change-password') return null;
        return '/change-password';
      }

      if (auth is Authenticated) {
        if (loc == '/login' ||
            loc == '/register' ||
            loc == '/change-password') {
          return '/inbox';
        }
        // Staff guard: non-staff hitting /admin/* → /
        if (loc.startsWith('/admin') && !auth.user.isStaff) {
          return '/inbox';
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, _) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, _) => const ChangePasswordScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(path: '/inbox', builder: (context, _) => const _InboxRoute()),
          GoRoute(
            path: '/mailbox/:mailboxId',
            builder: (_, state) => AdaptiveMailboxView(
              mailboxId: state.pathParameters['mailboxId']!,
            ),
            routes: [
              GoRoute(
                path: 'thread/:threadId',
                builder: (_, state) => ThreadDetailScreen(
                  threadId: state.pathParameters['threadId']!,
                  mailboxId: state.pathParameters['mailboxId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/compose',
            builder: (context, state) => ComposeScreen(
              replyToMessageId: state.uri.queryParameters['reply'],
              mode: state.uri.queryParameters['mode'],
              to: state.uri.queryParameters['to'],
            ),
          ),
          GoRoute(
            path: '/contacts',
            builder: (context, _) => const ContactsScreen(),
          ),
          GoRoute(
            path: '/labels',
            builder: (context, _) => const LabelsScreen(),
          ),
          GoRoute(path: '/rules', builder: (context, _) => const RulesScreen()),
          GoRoute(
            path: '/settings',
            builder: (context, _) => const SettingsScreen(),
          ),
          // Admin routes (staff only — enforced by redirect guard above)
          GoRoute(path: '/admin', builder: (context, _) => const AdminScreen()),
          GoRoute(
            path: '/admin/providers',
            builder: (context, _) => const AdminProvidersScreen(),
          ),
          GoRoute(
            path: '/admin/domains',
            builder: (context, _) => const AdminDomainsScreen(),
          ),
          GoRoute(
            path: '/admin/mailboxes',
            builder: (context, _) => const AdminMailboxesScreen(),
          ),
          GoRoute(
            path: '/admin/users',
            builder: (context, _) => const AdminUsersScreen(),
          ),
          GoRoute(
            path: '/admin/access',
            builder: (context, _) => const AdminAccessScreen(),
          ),
          GoRoute(
            path: '/admin/delivery',
            builder: (context, _) => const AdminDeliveryScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (_, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
