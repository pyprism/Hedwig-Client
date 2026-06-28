import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_providers_screen.g.dart';

class EmailProvider {
  const EmailProvider({
    required this.id,
    required this.name,
    required this.providerType,
    required this.isActive,
    this.defaultFromEmail,
    this.lastHealthCheckAt,
    this.lastHealthCheckError,
  });

  final String id;
  final String name;
  final String providerType;
  final bool isActive;
  final String? defaultFromEmail;
  final DateTime? lastHealthCheckAt;
  final String? lastHealthCheckError;

  factory EmailProvider.fromJson(Map<String, dynamic> j) => EmailProvider(
        id: j['id'] as String,
        name: j['name'] as String,
        providerType: j['provider_type'] as String? ?? '',
        isActive: j['is_active'] as bool? ?? true,
        defaultFromEmail: j['default_from_email'] as String?,
        lastHealthCheckAt: j['last_health_check_at'] == null
            ? null
            : DateTime.tryParse(j['last_health_check_at'] as String),
        lastHealthCheckError: j['last_health_check_error'] as String?,
      );
}

@riverpod
Future<List<EmailProvider>> adminProviders(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get('providers/email-providers/', queryParameters: {'page_size': 100});
  final results = (res.data['results'] as List? ?? []).cast<Map<String, dynamic>>();
  return results.map(EmailProvider.fromJson).toList();
}

class AdminProvidersScreen extends ConsumerWidget {
  const AdminProvidersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminProvidersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Email providers')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (providers) {
          if (providers.isEmpty) {
            return const EmptyState(
              icon: Icons.dns_outlined,
              title: 'No providers',
              subtitle: 'Add an email provider to start sending.',
            );
          }
          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, i) {
              final p = providers[i];
              final healthy = p.lastHealthCheckError == null;
              return ListTile(
                leading: Icon(
                  Icons.dns,
                  color: p.isActive
                      ? (healthy
                          ? Theme.of(context).colorScheme.primary
                          : Colors.orange)
                      : Theme.of(context).colorScheme.outline,
                ),
                title: Text(p.name),
                subtitle: Text(
                    '${p.providerType}${p.defaultFromEmail != null ? ' · ${p.defaultFromEmail}' : ''}'),
                trailing: p.lastHealthCheckError != null
                    ? Tooltip(
                        message: p.lastHealthCheckError!,
                        child: const Icon(Icons.warning_amber,
                            color: Colors.orange),
                      )
                    : const Icon(Icons.check_circle_outline,
                        color: Colors.green),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    final tokenCtrl = TextEditingController();
    final fromEmailCtrl = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add provider'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name')),
              const SizedBox(height: 8),
              TextField(
                  controller: tokenCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Postmark server token'),
                  obscureText: true),
              const SizedBox(height: 8),
              TextField(
                  controller: fromEmailCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Default from email')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                await ref.read(dioClientProvider).post(
                  'providers/email-providers/',
                  data: {
                    'name': nameCtrl.text.trim(),
                    'provider_type': 'postmark',
                    'credentials': {'server_token': tokenCtrl.text.trim()},
                    'default_from_email': fromEmailCtrl.text.trim(),
                  },
                );
                ref.invalidate(adminProvidersProvider);
              } on DioException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Error: ${e.response?.data ?? e.message}')),
                  );
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
    nameCtrl.dispose();
    tokenCtrl.dispose();
    fromEmailCtrl.dispose();
  }
}
