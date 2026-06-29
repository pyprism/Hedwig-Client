import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'outbox_badge.g.dart';

@riverpod
Stream<int> pendingOutboxCount(Ref ref) {
  return ref.watch(appDatabaseProvider).outboxDao.watchPendingCount();
}

@riverpod
Stream<int> deadLetterOutboxCount(Ref ref) {
  return ref.watch(appDatabaseProvider).outboxDao.watchDeadLetterCount();
}

/// Wraps [child] with a badge showing queued outbox count when > 0.
///
/// When entries have exhausted their retry budget (dead-lettered), the
/// badge switches to the error color and becomes tappable, opening a
/// dialog to retry or discard each one.
class OutboxBadge extends ConsumerWidget {
  const OutboxBadge({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(pendingOutboxCountProvider).value ?? 0;
    final deadLetterCount = ref.watch(deadLetterOutboxCountProvider).value ?? 0;

    if (count == 0 && deadLetterCount == 0) return child;

    final badge = Badge(
      label: Text('${count + deadLetterCount}'),
      backgroundColor: deadLetterCount > 0
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.tertiary,
      child: child,
    );

    if (deadLetterCount == 0) return badge;

    return GestureDetector(
      onTap: () => _showDeadLetterDialog(context),
      child: badge,
    );
  }

  void _showDeadLetterDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const _DeadLetterDialog(),
    );
  }
}

class _DeadLetterDialog extends ConsumerWidget {
  const _DeadLetterDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    return AlertDialog(
      title: const Text('Failed actions'),
      content: SizedBox(
        width: 400,
        child: StreamBuilder(
          stream: db.outboxDao.watchDeadLetter(),
          builder: (context, snapshot) {
            final entries = snapshot.data ?? const [];
            if (entries.isEmpty) {
              return const Text('Nothing failed.');
            }
            return SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, i) {
                  final entry = entries[i];
                  return ListTile(
                    title: Text(entry.operation),
                    subtitle: Text(
                      entry.lastError ?? 'Exceeded retry limit',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (entry.operation == 'send_message')
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            tooltip: 'Edit',
                            onPressed: () => _editSend(context, db, entry),
                          ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          tooltip: 'Retry',
                          onPressed: () => db.outboxDao.retry(entry.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Discard',
                          onPressed: () => db.outboxDao.discard(entry.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<void> _editSend(
    BuildContext context,
    AppDatabase db,
    OutboxEntry entry,
  ) async {
    try {
      final payload = jsonDecode(entry.payloadJson) as Map<String, dynamic>;
      final body = payload['body'] as Map<String, dynamic>;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'compose_draft_new',
        jsonEncode({
          'to': _recipientEmails(body['to']),
          'cc': _recipientEmails(body['cc']),
          'bcc': _recipientEmails(body['bcc']),
          'subject': body['subject'] as String? ?? '',
          'body':
              body['body_html'] as String? ??
              body['body_text'] as String? ??
              '',
          'compose_html': body['body_html'] != null,
        }),
      );
      await db.outboxDao.discard(entry.id);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      unawaited(context.push('/compose'));
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not restore failed draft.')),
      );
    }
  }

  List<String> _recipientEmails(Object? rows) {
    if (rows is! List) return [];
    return rows
        .map((row) {
          if (row is String) return row;
          if (row is Map) return row['email'] as String? ?? '';
          return '';
        })
        .where((email) => email.isNotEmpty)
        .toList();
  }
}
