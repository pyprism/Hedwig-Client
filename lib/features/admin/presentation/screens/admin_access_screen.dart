import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
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
                trailing: g.expiresAt != null
                    ? Text(
                        'Expires ${_fmt(g.expiresAt!)}',
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  String _fmt(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
}
