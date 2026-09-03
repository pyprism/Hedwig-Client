import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/api/paginated_fetch.dart';
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
    required this.isCatchAll,
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
  final bool isCatchAll;
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
    isCatchAll: j['is_catch_all'] as bool? ?? false,
    domainId: j['domain'] as String?,
  );
}

@riverpod
Future<List<AdminMailbox>> adminMailboxes(Ref ref) => fetchAllPages(
  ref.watch(dioClientProvider),
  'mail/mailboxes/',
  AdminMailbox.fromJson,
  queryParameters: {'page_size': 100},
);

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
          final domainsMissingCatchAll = _domainsMissingCatchAll(mailboxes);
          return Column(
            children: [
              if (domainsMissingCatchAll.isNotEmpty)
                _NoCatchAllBanner(domains: domainsMissingCatchAll),
              Expanded(
                child: ListView.builder(
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
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: Text(m.emailAddress)),
                          if (m.isCatchAll) ...[
                            const SizedBox(width: 8),
                            Tooltip(
                              message:
                                  'Catch-all — receives mail to any unrecognized '
                                  'address on ${m.emailAddress.split('@').last}',
                              child: Chip(
                                label: const Text('Unassigned mail'),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall,
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ],
                      ),
                      subtitle: m.displayName != null
                          ? Text(m.displayName!)
                          : null,
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
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final localPartCtrl = TextEditingController();
    final displayNameCtrl = TextEditingController();
    final quotaCtrl = TextEditingController();

    // Fetch domains for picker. `domainsLoadFailed` is tracked separately
    // from `domains.isEmpty` so a network/403 failure while fetching domains
    // doesn't render identically to "no domains configured yet" — both used
    // to collapse into the same empty/disabled picker, risking an admin
    // submitting a mailbox with no domain context because they couldn't tell
    // the difference.
    List<Map<String, dynamic>> domains = [];
    String? selectedDomainId;
    bool domainsLoadFailed = false;
    Future<void> loadDomains() async {
      try {
        domains = await fetchAllPages(
          ref.read(dioClientProvider),
          'providers/domains/',
          (m) => m,
          queryParameters: {'page_size': 100},
        );
        domainsLoadFailed = false;
        if (domains.isNotEmpty) {
          selectedDomainId = domains.first['id'] as String;
        }
      } catch (_) {
        domainsLoadFailed = true;
      }
    }

    await loadDomains();

    if (!context.mounted) {
      localPartCtrl.dispose();
      displayNameCtrl.dispose();
      quotaCtrl.dispose();
      return;
    }

    bool isCatchAll = false;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New mailbox'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (domainsLoadFailed)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Couldn\'t load domains.',
                          style: TextStyle(
                            color: Theme.of(ctx).colorScheme.error,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await loadDomains();
                          setState(() {});
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  )
                else if (domains.isNotEmpty)
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
                  const Text(
                    'No domains found. Add one under Admin → Domains.',
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
                  value: isCatchAll,
                  onChanged: (v) => setState(() => isCatchAll = v),
                  title: const Text('Catch-all (unassigned mail)'),
                  subtitle: const Text(
                    'Receives mail to any address on this domain that no '
                    'other mailbox or alias claims. At most one per domain.',
                  ),
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
                                'is_catch_all': isCatchAll,
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
    bool domainsLoadFailed = false;
    Future<void> loadDomains() async {
      try {
        domains = await fetchAllPages(
          ref.read(dioClientProvider),
          'providers/domains/',
          (m) => m,
          queryParameters: {'page_size': 100},
        );
        domainsLoadFailed = false;
      } catch (_) {
        domainsLoadFailed = true;
      }
    }

    await loadDomains();

    if (!context.mounted) {
      localPartCtrl.dispose();
      displayNameCtrl.dispose();
      quotaCtrl.dispose();
      return;
    }

    bool sendEnabled = mailbox.sendEnabled;
    bool receiveEnabled = mailbox.receiveEnabled;
    bool isActive = mailbox.isActive;
    bool isCatchAll = mailbox.isCatchAll;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Edit ${mailbox.emailAddress}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // `domainsLoadFailed` is tracked separately from
                // `domains.isEmpty` so a load failure (offline, 403) doesn't
                // render identically to "no domains configured" — both used
                // to collapse into the same empty/disabled picker.
                if (domainsLoadFailed)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Couldn\'t load domains.',
                          style: TextStyle(
                            color: Theme.of(ctx).colorScheme.error,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await loadDomains();
                          setState(() {});
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  )
                else if (domains.isNotEmpty)
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
                SwitchListTile(
                  value: isCatchAll,
                  onChanged: (v) => setState(() => isCatchAll = v),
                  title: const Text('Catch-all (unassigned mail)'),
                  subtitle: const Text(
                    'Receives mail to any address on this domain that no '
                    'other mailbox or alias claims. At most one per domain.',
                  ),
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
                                'is_catch_all': isCatchAll,
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

/// Domains (by name, derived from `email_address` — this screen doesn't
/// fetch the domains list separately) that have at least one active,
/// receive-enabled mailbox but none marked catch-all: mail to any address on
/// that domain nobody explicitly provisioned is being silently dropped.
List<String> _domainsMissingCatchAll(List<AdminMailbox> mailboxes) {
  final receivingDomains = <String>{};
  final catchAllDomains = <String>{};
  for (final m in mailboxes) {
    final domain = m.emailAddress.split('@').last;
    if (domain.isEmpty) continue;
    if (m.isActive && m.receiveEnabled) receivingDomains.add(domain);
    if (m.isCatchAll) catchAllDomains.add(domain);
  }
  return receivingDomains.difference(catchAllDomains).toList()..sort();
}

class _NoCatchAllBanner extends StatelessWidget {
  const _NoCatchAllBanner({required this.domains});

  final List<String> domains;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: scheme.errorContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: scheme.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              domains.length == 1
                  ? 'Mail to any unrecognized address on "${domains.first}" '
                        'is being silently discarded — no mailbox on that '
                        'domain is marked catch-all.'
                  : '${domains.length} domains have no catch-all mailbox — '
                        'mail to unrecognized addresses on '
                        '${domains.join(", ")} is being silently discarded.',
              style: TextStyle(color: scheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
