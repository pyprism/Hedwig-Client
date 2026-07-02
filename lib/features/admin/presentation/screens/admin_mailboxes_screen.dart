import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/confirm_delete_dialog.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_mailboxes_screen.g.dart';

const _bytesPerMb = 1024 * 1024;

class AdminMailbox {
  const AdminMailbox({
    required this.id,
    required this.emailAddress,
    required this.displayName,
    required this.isActive,
    required this.sendEnabled,
    required this.receiveEnabled,
    required this.localPart,
    required this.quotaBytes,
    this.domainId,
  });

  final String id;
  final String emailAddress;
  final String? displayName;
  final bool isActive;
  final bool sendEnabled;
  final bool receiveEnabled;
  final String localPart;
  final int quotaBytes;
  final String? domainId;

  factory AdminMailbox.fromJson(Map<String, dynamic> j) => AdminMailbox(
    id: j['id'] as String,
    emailAddress: j['email_address'] as String? ?? '',
    displayName: j['display_name'] as String?,
    isActive: j['is_active'] as bool? ?? true,
    sendEnabled: j['send_enabled'] as bool? ?? true,
    receiveEnabled: j['receive_enabled'] as bool? ?? true,
    localPart: j['local_part'] as String? ?? '',
    quotaBytes: (j['quota_bytes'] as num?)?.toInt() ?? 0,
    domainId: j['domain'] as String?,
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
                        child: Icon(
                          Icons.block,
                          size: 16,
                          color: Colors.orange,
                        ),
                      ),
                    if (!m.isActive)
                      const Tooltip(
                        message: 'Inactive',
                        child: Icon(
                          Icons.pause_circle_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                    PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'edit') {
                          _showEditDialog(context, ref, m);
                        } else if (v == 'delete') {
                          _deleteMailbox(context, ref, m);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
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

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final localPartCtrl = TextEditingController();
    final displayNameCtrl = TextEditingController();
    final quotaCtrl = TextEditingController();

    // Fetch domains for picker
    List<Map<String, dynamic>> domains = [];
    String? selectedDomainId;
    try {
      final res = await ref
          .read(dioClientProvider)
          .get('providers/domains/', queryParameters: {'page_size': 100});
      domains = (res.data['results'] as List? ?? [])
          .cast<Map<String, dynamic>>();
      if (domains.isNotEmpty) selectedDomainId = domains.first['id'] as String;
    } catch (_) {}

    if (!context.mounted) {
      localPartCtrl.dispose();
      displayNameCtrl.dispose();
      quotaCtrl.dispose();
      return;
    }

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
                      .map(
                        (d) => DropdownMenuItem(
                          value: d['id'] as String,
                          child: Text(
                            '${d['name'] ?? ''}'
                            '${d['status'] != null && d['status'] != 'verified' ? ' (${d['status']})' : ''}',
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => selectedDomainId = v),
                )
              else
                const Text('No domains found. Add one under Admin → Domains.'),
              const SizedBox(height: 8),
              TextField(
                controller: localPartCtrl,
                decoration: const InputDecoration(
                  labelText: 'Local part (before @)',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: displayNameCtrl,
                decoration: const InputDecoration(labelText: 'Display name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: quotaCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Storage quota (MB)',
                  hintText: 'Blank or 0 = unlimited',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: selectedDomainId == null
                  ? null
                  : () async {
                      Navigator.of(ctx).pop();
                      final quotaMb = int.tryParse(quotaCtrl.text.trim());
                      try {
                        await ref
                            .read(dioClientProvider)
                            .post(
                              'mail/mailboxes/',
                              data: {
                                'domain': selectedDomainId,
                                'local_part': localPartCtrl.text.trim(),
                                if (displayNameCtrl.text.trim().isNotEmpty)
                                  'display_name': displayNameCtrl.text.trim(),
                                if (quotaMb != null)
                                  'quota_bytes': quotaMb * _bytesPerMb,
                              },
                            );
                        ref.invalidate(adminMailboxesProvider);
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
    localPartCtrl.dispose();
    displayNameCtrl.dispose();
    quotaCtrl.dispose();
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    AdminMailbox mailbox,
  ) async {
    final localPartCtrl = TextEditingController(text: mailbox.localPart);
    final displayNameCtrl = TextEditingController(
      text: mailbox.displayName ?? '',
    );
    final quotaCtrl = TextEditingController(
      text: mailbox.quotaBytes > 0
          ? (mailbox.quotaBytes / _bytesPerMb).round().toString()
          : '',
    );

    List<Map<String, dynamic>> domains = [];
    String? selectedDomainId = mailbox.domainId;
    try {
      final res = await ref
          .read(dioClientProvider)
          .get('providers/domains/', queryParameters: {'page_size': 100});
      domains = (res.data['results'] as List? ?? [])
          .cast<Map<String, dynamic>>();
    } catch (_) {}

    if (!context.mounted) {
      localPartCtrl.dispose();
      displayNameCtrl.dispose();
      quotaCtrl.dispose();
      return;
    }

    bool sendEnabled = mailbox.sendEnabled;
    bool receiveEnabled = mailbox.receiveEnabled;
    bool isActive = mailbox.isActive;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Edit ${mailbox.emailAddress}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (domains.isNotEmpty)
                  DropdownButtonFormField<String>(
                    initialValue: selectedDomainId,
                    decoration: const InputDecoration(labelText: 'Domain'),
                    items: domains
                        .map(
                          (d) => DropdownMenuItem(
                            value: d['id'] as String,
                            child: Text(d['name'] as String? ?? ''),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => selectedDomainId = v),
                  ),
                const SizedBox(height: 8),
                TextField(
                  controller: localPartCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Local part (before @)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: displayNameCtrl,
                  decoration: const InputDecoration(labelText: 'Display name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: quotaCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Storage quota (MB)',
                    hintText: 'Blank or 0 = unlimited',
                  ),
                ),
                SwitchListTile(
                  value: sendEnabled,
                  onChanged: (v) => setState(() => sendEnabled = v),
                  title: const Text('Send enabled'),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: receiveEnabled,
                  onChanged: (v) => setState(() => receiveEnabled = v),
                  title: const Text('Receive enabled'),
                  contentPadding: EdgeInsets.zero,
                ),
                SwitchListTile(
                  value: isActive,
                  onChanged: (v) => setState(() => isActive = v),
                  title: const Text('Active'),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: selectedDomainId == null
                  ? null
                  : () async {
                      Navigator.of(ctx).pop();
                      final quotaMb = int.tryParse(quotaCtrl.text.trim()) ?? 0;
                      try {
                        await ref
                            .read(dioClientProvider)
                            .patch(
                              'mail/mailboxes/${mailbox.id}/',
                              data: {
                                'domain': selectedDomainId,
                                'local_part': localPartCtrl.text.trim(),
                                'display_name': displayNameCtrl.text.trim(),
                                'send_enabled': sendEnabled,
                                'receive_enabled': receiveEnabled,
                                'is_active': isActive,
                                'quota_bytes': quotaMb * _bytesPerMb,
                              },
                            );
                        ref.invalidate(adminMailboxesProvider);
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
    localPartCtrl.dispose();
    displayNameCtrl.dispose();
    quotaCtrl.dispose();
  }

  Future<void> _deleteMailbox(
    BuildContext context,
    WidgetRef ref,
    AdminMailbox mailbox,
  ) async {
    final ok = await confirmDelete(
      context,
      title: 'Delete mailbox?',
      message: 'Delete "${mailbox.emailAddress}"? This cannot be undone.',
    );
    if (!ok) return;
    try {
      await ref.read(dioClientProvider).delete('mail/mailboxes/${mailbox.id}/');
      ref.invalidate(adminMailboxesProvider);
    } on DioException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.response?.data ?? e.message}')),
        );
      }
    }
  }
}
