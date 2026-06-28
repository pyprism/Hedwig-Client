import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/features/labels/presentation/controllers/label_controller.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/shared/models/label.dart';

class LabelsScreen extends ConsumerWidget {
  const LabelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(labelActionsProvider, (previous, next) {
      if (!next.hasError) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failureFromError(next.error!).userMessage)),
      );
    });

    final mailboxId = ref.watch(selectedMailboxProvider);
    if (mailboxId == null) {
      return const Scaffold(body: LoadingWidget());
    }

    final labelsAsync = ref.watch(labelListProvider(mailboxId));

    return Scaffold(
      appBar: AppBar(title: const Text('Labels')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref, mailboxId),
        child: const Icon(Icons.label_important_outline),
      ),
      body: labelsAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => ErrorDisplay(failure: failureFromError(e)),
        data: (labels) {
          if (labels.isEmpty) {
            return const EmptyState(
              icon: Icons.label_outline,
              title: 'No labels',
              subtitle: 'Create labels to organize your messages.',
            );
          }
          return ListView.builder(
            itemCount: labels.length,
            itemBuilder: (context, i) =>
                _LabelTile(label: labels[i], mailboxId: mailboxId),
          );
        },
      ),
    );
  }

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    String mailboxId,
  ) async {
    final nameCtrl = TextEditingController();
    String? selectedColor;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New label'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Label name'),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _colorOptions.map((c) {
                  final color = Color(int.parse('0xFF${c.substring(1)}'));
                  return GestureDetector(
                    onTap: () => setState(() => selectedColor = c),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: color,
                      child: selectedColor == c
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                ref
                    .read(labelActionsProvider.notifier)
                    .create(
                      mailboxId: mailboxId,
                      name: nameCtrl.text.trim(),
                      color: selectedColor,
                    );
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
    nameCtrl.dispose();
  }

  static const _colorOptions = [
    '#E53935',
    '#E91E63',
    '#9C27B0',
    '#3F51B5',
    '#2196F3',
    '#009688',
    '#4CAF50',
    '#FF9800',
  ];
}

class _LabelTile extends ConsumerWidget {
  const _LabelTile({required this.label, required this.mailboxId});

  final Label label;
  final String mailboxId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = label.color != null
        ? Color(int.parse('0xFF${label.color!.substring(1)}'))
        : Theme.of(context).colorScheme.primary;

    return ListTile(
      leading: Icon(Icons.label, color: color),
      title: Text(label.name),
      trailing: PopupMenuButton<String>(
        onSelected: (v) {
          if (v == 'delete') {
            ref.read(labelActionsProvider.notifier).delete(label.id);
          }
        },
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
