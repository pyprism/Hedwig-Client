import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/confirm_delete_dialog.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_access_screen.g.dart';

class AccessGrant {
  const AccessGrant({
    required this.id,
    required this.username,
    required this.permission,
    required this.accessType,
    required this.isActive,
    this.mailboxEmail,
    this.domainName,
    this.expiresAt,
  });

  final String id;
  final String username;
  final String permission;
  final String accessType;
  final bool isActive;
  final String? mailboxEmail;
  final String? domainName;
  final DateTime? expiresAt;

  factory AccessGrant.fromJson(Map<String, dynamic> j) => AccessGrant(
    id: j['id'] as String,
    username:
        (j['user'] as Map<String, dynamic>?)?['username'] as String? ??
        j['user'] as String? ??
        '?',
    permission: j['permission'] as String? ?? '',
    accessType: j['access_type'] as String? ?? '',
    isActive: j['is_active'] as bool? ?? true,
    mailboxEmail:
        (j['mailbox'] as Map<String, dynamic>?)?['email_address'] as String?,
    domainName: (j['domain'] as Map<String, dynamic>?)?['name'] as String?,
    expiresAt: j['expires_at'] == null
        ? null
        : DateTime.tryParse(j['expires_at'] as String),
  );
}

@riverpod
Future<List<AccessGrant>> adminAccessGrants(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get('mail/mailbox-accesses/', queryParameters: {'page_size': 100});
  return (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(AccessGrant.fromJson)
      .toList();
}

class AdminAccessScreen extends ConsumerWidget {
  const AdminAccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminAccessGrantsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Access grants')),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (grants) {
          if (grants.isEmpty) {
            return const EmptyState(
              icon: Icons.key_outlined,
              title: 'No access grants',
              subtitle: 'Grant users access to mailboxes or domains.',
            );
          }
          return ListView.builder(
            itemCount: grants.length,
            itemBuilder: (context, i) {
              final g = grants[i];
              final scope = g.mailboxEmail ?? g.domainName ?? g.accessType;
              return ListTile(
                leading: Icon(
                  Icons.key,
                  color: g.isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
                title: Text(g.username),
                subtitle: Text('$scope · ${g.permission}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (g.expiresAt != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          'Expires ${_fmt(g.expiresAt!)}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'edit') {
                          _showEditDialog(context, ref, g);
                        } else if (v == 'delete') {
                          _deleteGrant(context, ref, g);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Revoke')),
                      ],
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

  String _fmt(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    AccessGrant grant,
  ) async {
    const permissions = ['read_only', 'read_write', 'full_access'];
    String permission = permissions.contains(grant.permission)
        ? grant.permission
        : permissions.first;
    bool isActive = grant.isActive;
    DateTime? expiresAt = grant.expiresAt;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Edit access for ${grant.username}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: permission,
                decoration: const InputDecoration(labelText: 'Permission'),
                items: permissions
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => setState(() => permission = v ?? permission),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  expiresAt == null
                      ? 'No expiry'
                      : 'Expires ${_fmt(expiresAt!)}',
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today, size: 18),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate: expiresAt ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 3650),
                          ),
                        );
                        if (picked != null) {
                          setState(() => expiresAt = picked);
                        }
                      },
                    ),
                    if (expiresAt != null)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() => expiresAt = null),
                      ),
                  ],
                ),
              ),
              SwitchListTile(
                value: isActive,
                onChanged: (v) => setState(() => isActive = v),
                title: const Text('Active'),
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
                      .patch(
                        'mail/mailbox-accesses/${grant.id}/',
                        data: {
                          'permission': permission,
                          'is_active': isActive,
                          'expires_at': expiresAt?.toIso8601String(),
                        },
                      );
                  ref.invalidate(adminAccessGrantsProvider);
                } on DioException catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error: ${e.response?.data ?? e.message}',
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteGrant(
    BuildContext context,
    WidgetRef ref,
    AccessGrant grant,
  ) async {
    final ok = await confirmDelete(
      context,
      title: 'Revoke access?',
      message: 'Revoke ${grant.username}\'s access? This cannot be undone.',
    );
    if (!ok) return;
    try {
      await ref
          .read(dioClientProvider)
          .delete('mail/mailbox-accesses/${grant.id}/');
      ref.invalidate(adminAccessGrantsProvider);
    } on DioException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.response?.data ?? e.message}')),
        );
      }
    }
  }
}
