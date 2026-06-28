import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_mailboxes_screen.g.dart';

class AdminMailbox {
  const AdminMailbox({
    required this.id,
    required this.emailAddress,
    required this.displayName,
    required this.isActive,
    required this.sendEnabled,
  });

  final String id;
  final String emailAddress;
  final String? displayName;
  final bool isActive;
  final bool sendEnabled;

  factory AdminMailbox.fromJson(Map<String, dynamic> j) => AdminMailbox(
        id: j['id'] as String,
        emailAddress: j['email_address'] as String? ?? '',
        displayName: j['display_name'] as String?,
        isActive: j['is_active'] as bool? ?? true,
        sendEnabled: j['send_enabled'] as bool? ?? true,
      );
}

@riverpod
Future<List<AdminMailbox>> adminMailboxes(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get('mail/mailboxes/', queryParameters: {'page_size': 100});
  return (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(AdminMailbox.fromJson)
      .toList();
}

class AdminMailboxesScreen extends ConsumerWidget {
  const AdminMailboxesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminMailboxesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mailboxes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (mailboxes) {
          if (mailboxes.isEmpty) {
            return const EmptyState(
              icon: Icons.inbox_outlined,
              title: 'No mailboxes',
              subtitle: 'Create a mailbox on a verified domain.',
            );
          }
          return ListView.builder(
            itemCount: mailboxes.length,
            itemBuilder: (context, i) {
              final m = mailboxes[i];
              return ListTile(
                leading: Icon(
                  Icons.inbox,
                  color: m.isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
                title: Text(m.emailAddress),
                subtitle: m.displayName != null ? Text(m.displayName!) : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!m.sendEnabled)
                      const Tooltip(
                        message: 'Send disabled',
                        child: Icon(Icons.block, size: 16, color: Colors.orange),
                      ),
                    if (!m.isActive)
                      const Tooltip(
                        message: 'Inactive',
                        child: Icon(Icons.pause_circle_outline,
                            size: 16, color: Colors.grey),
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
    final localPartCtrl = TextEditingController();
    final displayNameCtrl = TextEditingController();

    // Fetch domains for picker
    List<Map<String, dynamic>> domains = [];
    String? selectedDomainId;
    try {
      final res = await ref
          .read(dioClientProvider)
          .get('providers/domains/', queryParameters: {'page_size': 100, 'status': 'verified'});
      domains = (res.data['results'] as List? ?? []).cast<Map<String, dynamic>>();
      if (domains.isNotEmpty) selectedDomainId = domains.first['id'] as String;
    } catch (_) {}

    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New mailbox'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (domains.isNotEmpty)
                DropdownButtonFormField<String>(
                  initialValue: selectedDomainId,
                  decoration: const InputDecoration(labelText: 'Domain'),
                  items: domains
                      .map((d) => DropdownMenuItem(
                            value: d['id'] as String,
                            child: Text(d['name'] as String? ?? ''),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => selectedDomainId = v),
                )
              else
                const Text('No verified domains found.'),
              const SizedBox(height: 8),
              TextField(
                  controller: localPartCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Local part (before @)')),
              const SizedBox(height: 8),
              TextField(
                  controller: displayNameCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Display name')),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel')),
            FilledButton(
              onPressed: selectedDomainId == null
                  ? null
                  : () async {
                      Navigator.of(ctx).pop();
                      try {
                        await ref.read(dioClientProvider).post(
                          'mail/mailboxes/',
                          data: {
                            'domain': selectedDomainId,
                            'local_part': localPartCtrl.text.trim(),
                            if (displayNameCtrl.text.trim().isNotEmpty)
                              'display_name': displayNameCtrl.text.trim(),
                          },
                        );
                        ref.invalidate(adminMailboxesProvider);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
    localPartCtrl.dispose();
    displayNameCtrl.dispose();
  }
}
