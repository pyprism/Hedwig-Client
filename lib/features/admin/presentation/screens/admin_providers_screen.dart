import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/confirm_delete_dialog.dart';
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
  final results = (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>();
  return results.map(EmailProvider.fromJson).toList();
}

class AdminProvidersScreen extends ConsumerWidget {
  const AdminProvidersScreen({super.key});

  static final Map<String, String> _sessionWebhookSecrets = {};

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
                  '${p.providerType}${p.defaultFromEmail != null ? ' · ${p.defaultFromEmail}' : ''}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (p.lastHealthCheckError != null)
                      IconButton(
                        icon: const Icon(
                          Icons.warning_amber_outlined,
                          color: Colors.orange,
                        ),
                        tooltip: 'View provider warning',
                        onPressed: () => _showProviderWarning(context, p),
                      )
                    else
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'details') {
                          _showProviderDetails(context, ref, p);
                        } else if (v == 'edit') {
                          _showEditDialog(context, ref, p);
                        } else if (v == 'delete') {
                          _deleteProvider(context, ref, p);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'details', child: Text('Details')),
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

  void _showProviderDetails(
    BuildContext context,
    WidgetRef ref,
    EmailProvider provider,
  ) {
    final origin = _serverOrigin(ref.read(dioClientProvider).options.baseUrl);
    final secret = _sessionWebhookSecrets[provider.id];
    final secretParam = secret?.isNotEmpty == true
        ? Uri.encodeComponent(secret!)
        : 'YOUR_WEBHOOK_SECRET';
    final webhookUrl = origin == null
        ? null
        : '$origin/api/providers/postmark/webhooks/?provider=${provider.id}&secret=$secretParam';
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(provider.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Provider UUID'),
            const SizedBox(height: 4),
            SelectableText(provider.id),
            const SizedBox(height: 16),
            const Text('Postmark webhook URL'),
            const SizedBox(height: 4),
            SelectableText(webhookUrl ?? 'Configure server URL first.'),
            const SizedBox(height: 12),
            Text(
              secret?.isNotEmpty == true
                  ? 'The copied URL includes the webhook signing secret entered in this client session.'
                  : 'Set the same secret in Edit provider > Webhook signing secret, then replace YOUR_WEBHOOK_SECRET in the URL.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Clipboard.setData(ClipboardData(text: provider.id)),
            child: const Text('Copy UUID'),
          ),
          if (webhookUrl != null)
            TextButton(
              onPressed: () =>
                  Clipboard.setData(ClipboardData(text: webhookUrl)),
              child: const Text('Copy URL'),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String? _serverOrigin(String baseUrl) {
    final parsed = Uri.tryParse(baseUrl);
    if (parsed != null && parsed.hasScheme && parsed.hasAuthority) {
      return parsed.origin;
    }
    final current = Uri.base;
    if (current.hasScheme && current.hasAuthority) {
      return current.origin;
    }
    return null;
  }

  void _showProviderWarning(BuildContext context, EmailProvider provider) {
    final checkedAt = provider.lastHealthCheckAt;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${provider.name} warning'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (checkedAt != null) ...[
              Text('Last checked: ${checkedAt.toLocal()}'),
              const SizedBox(height: 12),
            ],
            Text(provider.lastHealthCheckError ?? 'No warning details.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    final tokenCtrl = TextEditingController();
    final accountTokenCtrl = TextEditingController();
    final webhookSecretCtrl = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: tokenCtrl,
                decoration: const InputDecoration(
                  labelText: 'Postmark server token',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: accountTokenCtrl,
                decoration: const InputDecoration(
                  labelText: 'Postmark account token',
                  hintText: 'Required for domain registration/DNS checks',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: webhookSecretCtrl,
                decoration: const InputDecoration(
                  labelText: 'Webhook signing secret',
                  hintText: 'Use this in the Postmark webhook URL',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: fromEmailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Default from email',
                ),
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
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                final res = await ref
                    .read(dioClientProvider)
                    .post(
                      'providers/email-providers/',
                      data: {
                        'name': nameCtrl.text.trim(),
                        'provider_type': 'postmark',
                        'credentials': {
                          'server_token': tokenCtrl.text.trim(),
                          if (accountTokenCtrl.text.trim().isNotEmpty)
                            'account_token': accountTokenCtrl.text.trim(),
                        },
                        if (webhookSecretCtrl.text.trim().isNotEmpty)
                          'webhook_signing_secret': webhookSecretCtrl.text
                              .trim(),
                        'default_from_email': fromEmailCtrl.text.trim(),
                      },
                    );
                final id =
                    (res.data as Map<String, dynamic>?)?['id'] as String?;
                final webhookSecret = webhookSecretCtrl.text.trim();
                if (id != null && webhookSecret.isNotEmpty) {
                  _sessionWebhookSecrets[id] = webhookSecret;
                }
                ref.invalidate(adminProvidersProvider);
              } on DioException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.response?.data ?? e.message}'),
                    ),
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
    accountTokenCtrl.dispose();
    webhookSecretCtrl.dispose();
    fromEmailCtrl.dispose();
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    EmailProvider provider,
  ) async {
    final nameCtrl = TextEditingController(text: provider.name);
    final tokenCtrl = TextEditingController();
    final accountTokenCtrl = TextEditingController();
    final webhookSecretCtrl = TextEditingController();
    final fromEmailCtrl = TextEditingController(
      text: provider.defaultFromEmail ?? '',
    );
    bool isActive = provider.isActive;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Edit provider'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: tokenCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Postmark server token',
                    hintText: 'Leave blank to keep existing',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: accountTokenCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Postmark account token',
                    hintText: 'Leave blank to keep existing',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: webhookSecretCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Webhook signing secret',
                    hintText: 'Leave blank to keep existing',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: fromEmailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Default from email',
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
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                final credentials = <String, dynamic>{
                  if (tokenCtrl.text.trim().isNotEmpty)
                    'server_token': tokenCtrl.text.trim(),
                  if (accountTokenCtrl.text.trim().isNotEmpty)
                    'account_token': accountTokenCtrl.text.trim(),
                };
                final webhookSecret = webhookSecretCtrl.text.trim();
                try {
                  await ref
                      .read(dioClientProvider)
                      .patch(
                        'providers/email-providers/${provider.id}/',
                        data: {
                          'name': nameCtrl.text.trim(),
                          'default_from_email': fromEmailCtrl.text.trim(),
                          'is_active': isActive,
                          if (credentials.isNotEmpty)
                            'credentials': credentials,
                          if (webhookSecret.isNotEmpty)
                            'webhook_signing_secret': webhookSecret,
                        },
                      );
                  if (webhookSecret.isNotEmpty) {
                    _sessionWebhookSecrets[provider.id] = webhookSecret;
                  }
                  ref.invalidate(adminProvidersProvider);
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
    nameCtrl.dispose();
    tokenCtrl.dispose();
    accountTokenCtrl.dispose();
    webhookSecretCtrl.dispose();
    fromEmailCtrl.dispose();
  }

  Future<void> _deleteProvider(
    BuildContext context,
    WidgetRef ref,
    EmailProvider provider,
  ) async {
    final ok = await confirmDelete(
      context,
      title: 'Delete provider?',
      message: 'Delete "${provider.name}"? Domains using it will stop sending.',
    );
    if (!ok) return;
    try {
      await ref
          .read(dioClientProvider)
          .delete('providers/email-providers/${provider.id}/');
      ref.invalidate(adminProvidersProvider);
    } on DioException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.response?.data ?? e.message}')),
        );
      }
    }
  }
}
