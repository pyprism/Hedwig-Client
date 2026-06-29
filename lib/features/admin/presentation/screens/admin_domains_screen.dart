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
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (domains) {
          if (domains.isEmpty) {
            return const EmptyState(
              icon: Icons.language,
              title: 'No domains',
              subtitle: 'Add a domain via your email provider first.',
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
