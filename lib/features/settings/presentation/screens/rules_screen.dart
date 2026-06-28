import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rules_screen.g.dart';

const mailboxRulesPath = 'mail/mailbox-rules/';

Map<String, dynamic> mailboxRulePayload({
  required String mailboxId,
  required String name,
  required String conditionField,
  required String conditionValue,
  required String actionType,
  required String actionValue,
}) => {
  'mailbox': mailboxId,
  'name': name,
  'conditions': {
    conditionField: conditionField == 'has_attachment' ? true : conditionValue,
  },
  'actions': {actionType: actionValue},
  'is_active': true,
};

class MailboxRule {
  const MailboxRule({
    required this.id,
    required this.name,
    required this.conditions,
    required this.actions,
    required this.isActive,
  });

  final String id;
  final String name;
  final Map<String, dynamic> conditions;
  final Map<String, dynamic> actions;
  final bool isActive;

  factory MailboxRule.fromJson(Map<String, dynamic> j) => MailboxRule(
    id: j['id'] as String,
    name: j['name'] as String? ?? '',
    conditions: (j['conditions'] as Map<String, dynamic>?) ?? {},
    actions: (j['actions'] as Map<String, dynamic>?) ?? {},
    isActive: j['is_active'] as bool? ?? true,
  );
}

@riverpod
Future<List<MailboxRule>> mailboxRules(Ref ref, String mailboxId) async {
  final dio = ref.watch(dioClientProvider);
  try {
    final res = await dio.get(
      mailboxRulesPath,
      queryParameters: {'mailbox': mailboxId, 'page_size': 100},
    );
    final results = (res.data['results'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    return results.map(MailboxRule.fromJson).toList();
  } on DioException catch (e) {
    throw Failure.server(
      statusCode: e.response?.statusCode ?? 0,
      message: e.message ?? 'Failed to load rules',
    );
  }
}

class RulesScreen extends ConsumerWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mailboxId = ref.watch(selectedMailboxProvider);
    if (mailboxId == null) {
      return const Scaffold(body: LoadingWidget());
    }

    final rulesAsync = ref.watch(mailboxRulesProvider(mailboxId));

    return Scaffold(
      appBar: AppBar(title: const Text('Mail rules')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRuleDialog(context, ref, mailboxId),
        child: const Icon(Icons.add),
      ),
      body: rulesAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => ErrorDisplay(failure: failureFromError(e)),
        data: (rules) {
          if (rules.isEmpty) {
            return const EmptyState(
              icon: Icons.filter_alt_outlined,
              title: 'No rules',
              subtitle: 'Create rules to automatically organize incoming mail.',
            );
          }
          return ListView.builder(
            itemCount: rules.length,
            itemBuilder: (context, i) =>
                _RuleTile(rule: rules[i], mailboxId: mailboxId),
          );
        },
      ),
    );
  }

  Future<void> _showAddRuleDialog(
    BuildContext context,
    WidgetRef ref,
    String mailboxId,
  ) async {
    final nameCtrl = TextEditingController();
    String conditionField = 'from_contains';
    final conditionValueCtrl = TextEditingController();
    String actionType = 'move_to_folder';
    String actionValue = 'archive';

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New rule'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Rule name'),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                Text('When', style: Theme.of(ctx).textTheme.labelLarge),
                const SizedBox(height: 8),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: conditionField,
                      onChanged: (v) => setState(() => conditionField = v!),
                      items: const [
                        DropdownMenuItem(
                          value: 'from_contains',
                          child: Text('From contains'),
                        ),
                        DropdownMenuItem(
                          value: 'subject_contains',
                          child: Text('Subject contains'),
                        ),
                        DropdownMenuItem(
                          value: 'to_contains',
                          child: Text('To contains'),
                        ),
                        DropdownMenuItem(
                          value: 'cc_contains',
                          child: Text('Cc contains'),
                        ),
                        DropdownMenuItem(
                          value: 'has_attachment',
                          child: Text('Has attachment'),
                        ),
                      ],
                    ),
                  ],
                ),
                if (conditionField != 'has_attachment')
                  TextField(
                    controller: conditionValueCtrl,
                    decoration: const InputDecoration(labelText: 'Value'),
                  ),
                const SizedBox(height: 16),
                Text('Then', style: Theme.of(ctx).textTheme.labelLarge),
                const SizedBox(height: 8),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: actionType,
                      onChanged: (v) => setState(() {
                        actionType = v!;
                        actionValue = actionType == 'move_to_folder'
                            ? 'archive'
                            : '';
                      }),
                      items: const [
                        DropdownMenuItem(
                          value: 'move_to_folder',
                          child: Text('Move to'),
                        ),
                        DropdownMenuItem(
                          value: 'forward_to',
                          child: Text('Forward to'),
                        ),
                        DropdownMenuItem(
                          value: 'add_label',
                          child: Text('Add label'),
                        ),
                      ],
                    ),
                    if (actionType == 'move_to_folder') ...[
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: actionValue,
                        onChanged: (v) => setState(() => actionValue = v!),
                        items: const [
                          DropdownMenuItem(
                            value: 'archive',
                            child: Text('Archive'),
                          ),
                          DropdownMenuItem(
                            value: 'trash',
                            child: Text('Trash'),
                          ),
                          DropdownMenuItem(value: 'spam', child: Text('Spam')),
                        ],
                      ),
                    ],
                    if (actionType != 'move_to_folder') ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (v) => actionValue = v,
                          decoration: InputDecoration(
                            labelText: actionType == 'add_label'
                                ? 'Label name'
                                : 'Email address',
                          ),
                        ),
                      ),
                    ],
                  ],
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
                  final dio = ref.read(dioClientProvider);
                  await dio.post(
                    mailboxRulesPath,
                    data: mailboxRulePayload(
                      mailboxId: mailboxId,
                      name: nameCtrl.text.trim(),
                      conditionField: conditionField,
                      conditionValue: conditionValueCtrl.text.trim(),
                      actionType: actionType,
                      actionValue: actionValue,
                    ),
                  );
                  ref.invalidate(mailboxRulesProvider);
                } catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(failureFromError(e).userMessage)),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
    nameCtrl.dispose();
    conditionValueCtrl.dispose();
  }
}

class _RuleTile extends ConsumerWidget {
  const _RuleTile({required this.rule, required this.mailboxId});

  final MailboxRule rule;
  final String mailboxId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final condSummary = rule.conditions.entries
        .map((e) => '${e.key}: ${e.value}')
        .join(' AND ');
    final actSummary = rule.actions.entries
        .map((e) => '${e.key}: ${e.value}')
        .join(', ');

    return ListTile(
      leading: Icon(
        Icons.filter_alt,
        color: rule.isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
      ),
      title: Text(rule.name.isNotEmpty ? rule.name : 'Unnamed rule'),
      subtitle: Text('If $condSummary → $actSummary', maxLines: 2),
      trailing: PopupMenuButton<String>(
        onSelected: (v) async {
          if (v == 'delete') {
            try {
              await ref
                  .read(dioClientProvider)
                  .delete('$mailboxRulesPath${rule.id}/');
              ref.invalidate(mailboxRulesProvider);
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(failureFromError(e).userMessage)),
              );
            }
          }
        },
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
