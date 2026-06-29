import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_users_screen.g.dart';

class AdminUser {
  const AdminUser({
    required this.id,
    required this.username,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.mustChangePassword,
    this.displayName,
    this.lastSeenAt,
  });

  final String id;
  final String username;
  final String email;
  final bool isStaff;
  final bool isActive;
  final bool mustChangePassword;
  final String? displayName;
  final DateTime? lastSeenAt;

  factory AdminUser.fromJson(Map<String, dynamic> j) => AdminUser(
    id: j['id'] as String,
    username: j['username'] as String,
    email: j['email'] as String? ?? '',
    isStaff: j['is_staff'] as bool? ?? false,
    isActive: j['is_active'] as bool? ?? true,
    mustChangePassword: j['must_change_password'] as bool? ?? false,
    displayName: j['display_name'] as String?,
    lastSeenAt: j['last_seen_at'] == null
        ? null
        : DateTime.tryParse(j['last_seen_at'] as String),
  );
}

@riverpod
Future<List<AdminUser>> adminUsers(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get('accounts/users/', queryParameters: {'page_size': 100});
  return (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(AdminUser.fromJson)
      .toList();
}

class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminUsersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.person_add),
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (users) {
          if (users.isEmpty) {
            return const EmptyState(
              icon: Icons.people_outline,
              title: 'No users',
            );
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, i) {
              final u = users[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  child: Text(
                    u.username.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                title: Text(u.displayName ?? u.username),
                subtitle: Text(u.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (u.isStaff)
                      const Tooltip(
                        message: 'Staff',
                        child: Icon(
                          Icons.admin_panel_settings_outlined,
                          size: 16,
                        ),
                      ),
                    if (!u.isActive)
                      const Tooltip(
                        message: 'Inactive',
                        child: Icon(Icons.block, size: 16, color: Colors.grey),
                      ),
                    if (u.mustChangePassword)
                      const Tooltip(
                        message: 'Must change password',
                        child: Icon(
                          Icons.lock_reset,
                          size: 16,
                          color: Colors.orange,
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final usernameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    bool mustChange = true;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Create user'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Temporary password',
                ),
                obscureText: true,
              ),
              CheckboxListTile(
                value: mustChange,
                onChanged: (v) => setState(() => mustChange = v ?? true),
                title: const Text('Must change password'),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                try {
                  await ref
                      .read(dioClientProvider)
                      .post(
                        'accounts/users/',
                        data: {
                          'username': usernameCtrl.text.trim(),
                          'email': emailCtrl.text.trim(),
                          'password': passwordCtrl.text,
                          'must_change_password': mustChange,
                        },
                      );
                  ref.invalidate(adminUsersProvider);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }
}
