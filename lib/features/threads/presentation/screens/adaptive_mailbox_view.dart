import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/utils/breakpoints.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/features/messages/presentation/screens/thread_detail_screen.dart';
import 'package:hedwig_client/features/threads/presentation/controllers/thread_controller.dart';
import 'package:hedwig_client/features/threads/presentation/screens/thread_list_screen.dart';

/// Shows ThreadList alone on compact/medium, side-by-side with detail on expanded.
class AdaptiveMailboxView extends ConsumerWidget {
  const AdaptiveMailboxView({super.key, required this.mailboxId});

  final String mailboxId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = context.isExpanded;
    final selectedThreadId = ref.watch(selectedThreadProvider);

    if (!isExpanded) {
      return ThreadListScreen(
        mailboxId: mailboxId,
        onThreadTap: (thread) =>
            context.push('/mailbox/$mailboxId/thread/${thread.id}'),
      );
    }

    // Expanded: two-pane
    return Row(
      children: [
        SizedBox(
          width: 380,
          child: ThreadListScreen(
            mailboxId: mailboxId,
            onThreadTap: (thread) =>
                ref.read(selectedThreadProvider.notifier).select(thread.id),
            selectedThreadId: selectedThreadId,
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: selectedThreadId != null
              ? ThreadDetailScreen(
                  mailboxId: mailboxId,
                  threadId: selectedThreadId,
                )
              : const EmptyState(
                  icon: Icons.mail_outline,
                  title: 'Select a conversation',
                  subtitle: 'Pick a thread from the list to read it here.',
                ),
        ),
      ],
    );
  }
}
