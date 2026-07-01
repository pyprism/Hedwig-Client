import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_domains_screen.g.dart';

class AdminDomain {
  const AdminDomain({
    required this.id,
    required this.name,
    required this.status,
    required this.outboundEnabled,
    required this.inboundEnabled,
    this.dnsRecordSet = const [],
  });

  final String id;
  final String name;
  final String status;
  final bool outboundEnabled;
  final bool inboundEnabled;
  final List<Map<String, dynamic>> dnsRecordSet;

  factory AdminDomain.fromJson(Map<String, dynamic> j) => AdminDomain(
    id: j['id'] as String,
    name: j['name'] as String,
    status: j['status'] as String? ?? 'pending',
    outboundEnabled: j['outbound_enabled'] as bool? ?? true,
    inboundEnabled: j['inbound_enabled'] as bool? ?? true,
    dnsRecordSet: (j['dns_record_set'] as List? ?? [])
        .cast<Map<String, dynamic>>(),
  );
}

@riverpod
Future<List<AdminDomain>> adminDomains(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get('providers/domains/', queryParameters: {'page_size': 100});
  return (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(AdminDomain.fromJson)
      .toList();
}

class AdminDomainsScreen extends ConsumerWidget {
  const AdminDomainsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminDomainsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Domains')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (domains) {
          if (domains.isEmpty) {
            return const EmptyState(
              icon: Icons.language,
              title: 'No domains',
              subtitle: 'Tap + to add a domain, then verify its DNS records.',
            );
          }
          return ListView.builder(
            itemCount: domains.length,
            itemBuilder: (context, i) {
              final d = domains[i];
              final color = switch (d.status) {
                'verified' => Colors.green,
                'failed' => Colors.red,
                _ => Colors.orange,
              };
              return ExpansionTile(
                leading: Icon(Icons.language, color: color),
                title: Text(d.name),
                subtitle: Text(d.status.toUpperCase()),
                children: [
                  if (d.dnsRecordSet.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No DNS records found.'),
                    )
                  else
                    ...d.dnsRecordSet.map((rec) => _DnsRecordTile(record: rec)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
  final nameCtrl = TextEditingController();

  // Fetch providers for the picker — a domain must belong to one.
  List<Map<String, dynamic>> providers = [];
  String? selectedProviderId;
  try {
    final res = await ref
        .read(dioClientProvider)
        .get('providers/email-providers/', queryParameters: {'page_size': 100});
    providers = (res.data['results'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    if (providers.isNotEmpty) {
      selectedProviderId = providers.first['id'] as String;
    }
  } catch (_) {}

  if (!context.mounted) return;

  await showDialog<void>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: const Text('Add domain'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (providers.isNotEmpty)
              DropdownButtonFormField<String>(
                initialValue: selectedProviderId,
                decoration: const InputDecoration(labelText: 'Provider'),
                items: providers
                    .map(
                      (p) => DropdownMenuItem(
                        value: p['id'] as String,
                        child: Text(p['name'] as String? ?? ''),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => selectedProviderId = v),
              )
            else
              const Text('No providers found. Add a provider first.'),
            const SizedBox(height: 8),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Domain (e.g. example.com)',
                hintText: 'bare domain, no @ or /',
              ),
              autocorrect: false,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: selectedProviderId == null
                ? null
                : () async {
                    Navigator.of(ctx).pop();
                    try {
                      await ref
                          .read(dioClientProvider)
                          .post(
                            'providers/domains/',
                            data: {
                              'name': nameCtrl.text.trim().toLowerCase(),
                              'provider': selectedProviderId,
                              'outbound_enabled': true,
                              'inbound_enabled': true,
                            },
                          );
                      ref.invalidate(adminDomainsProvider);
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
            child: const Text('Add'),
          ),
        ],
      ),
    ),
  );
  nameCtrl.dispose();
}

class _DnsRecordTile extends StatelessWidget {
  const _DnsRecordTile({required this.record});

  final Map<String, dynamic> record;

  @override
  Widget build(BuildContext context) {
    final status = record['status'] as String? ?? 'pending';
    final verified = status == 'verified';
    return ListTile(
      dense: true,
      leading: Icon(
        verified ? Icons.check_circle : Icons.pending_outlined,
        color: verified ? Colors.green : Colors.orange,
        size: 18,
      ),
      title: Text(
        '${record['record_type']} ${record['host']}',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
      ),
      subtitle: Text(
        record['value'] as String? ?? '',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        record['purpose'] as String? ?? '',
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
