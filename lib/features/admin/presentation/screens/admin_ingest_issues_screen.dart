import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_domains_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_ingest_issues_screen.g.dart';

/// A `ProviderWebhookLog` row for a webhook the backend didn't process
/// successfully — e.g. `providers/ingest.py:resolve_mailbox()` finding no
/// mailbox/alias/catch-all match on a domain (the same gap the mailbox
/// screen's "no catch-all configured" banner flags before mail is even
/// dropped). Without this screen the only way to see these was the API or
/// Django admin directly.
class IngestIssue {
  const IngestIssue({
    required this.id,
    required this.eventType,
    required this.status,
    required this.receivedAt,
    required this.attemptCount,
    this.domainId,
    this.errorMessage,
  });

  final String id;
  final String eventType;
  final String status;
  final DateTime receivedAt;
  final int attemptCount;
  // `domain` on this endpoint is a plain FK id, not a nested object — resolve
  // it against adminDomainsProvider's already-loaded list for display.
  final String? domainId;
  final String? errorMessage;

  factory IngestIssue.fromJson(Map<String, dynamic> j) => IngestIssue(
    id: j['id'] as String,
    eventType: j['event_type'] as String? ?? '',
    status: j['status'] as String? ?? '',
    receivedAt:
        DateTime.tryParse(j['received_at'] as String? ?? '') ?? DateTime.now(),
    attemptCount: (j['attempt_count'] as num?)?.toInt() ?? 0,
    domainId: j['domain'] as String?,
    errorMessage: j['error_message'] as String?,
  );
}

// Unlike the other admin list screens, this endpoint's rows are never
// deleted (only `redact_old_webhook_payloads_task` blanks payload/headers)
// and each row carries a full raw webhook body — following `next` here
// (fetchAllPages) would grow unbounded over an app's lifetime, drag along
// raw payload/header bytes for every row, and hammer the 150/min auth
// throttle on exactly the screen an admin opens when routing is already
// broken. Stick to a single bounded recent-window request, like
// admin_delivery_screen.dart does.
@riverpod
Future<List<IngestIssue>> adminIngestIssues(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get(
        'providers/provider-webhooks/',
        queryParameters: {
          'page_size': 50,
          'status': 'ignored',
          'ordering': '-received_at',
        },
      );
  return (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(IngestIssue.fromJson)
      .toList();
}

class AdminIngestIssuesScreen extends ConsumerWidget {
  const AdminIngestIssuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminIngestIssuesProvider);
    final domainNames = {
      for (final d in ref.watch(adminDomainsProvider).value ?? []) d.id: d.name,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingest issues'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(adminIngestIssuesProvider),
          ),
        ],
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (issues) {
          if (issues.isEmpty) {
            return const EmptyState(
              icon: Icons.check_circle_outline,
              title: 'No ingest issues',
              subtitle: 'Every recent inbound webhook was processed cleanly.',
            );
          }
          return ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, i) {
              final issue = issues[i];
              final domainName = domainNames[issue.domainId];
              return ListTile(
                leading: const Icon(
                  Icons.report_problem_outlined,
                  color: Colors.orange,
                ),
                title: Text(
                  domainName ?? issue.eventType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  issue.errorMessage ?? issue.eventType,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  _fmt(issue.receivedAt),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(domainName ?? issue.eventType),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Status: ${issue.status}'),
                          Text('Attempts: ${issue.attemptCount}'),
                          Text('Received: ${issue.receivedAt.toLocal()}'),
                          if (issue.errorMessage != null) ...[
                            const SizedBox(height: 8),
                            Text(issue.errorMessage!),
                          ],
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                      FilledButton(
                        onPressed: () => _reprocess(context, ref, issue),
                        child: const Text('Reprocess'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _reprocess(
    BuildContext context,
    WidgetRef ref,
    IngestIssue issue,
  ) async {
    Navigator.pop(context);
    try {
      await ref
          .read(dioClientProvider)
          .post('providers/provider-webhooks/${issue.id}/process/');
      ref.invalidate(adminIngestIssuesProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Reprocessing queued.')));
      }
    } on DioException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.response?.data ?? e.message}')),
        );
      }
    }
  }

  String _fmt(DateTime dt) {
    final d = dt.toLocal();
    return '${d.month}/${d.day} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }
}
