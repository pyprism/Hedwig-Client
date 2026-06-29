import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/utils/breakpoints.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/core/widgets/offline_banner.dart';
import 'package:hedwig_client/core/widgets/outbox_badge.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hedwig_client/features/labels/presentation/controllers/label_controller.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/features/threads/data/datasources/thread_remote_datasource.dart';
import 'package:hedwig_client/features/threads/data/repositories/thread_repository.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';

const _countRefreshInterval = Duration(seconds: 20);

final _countRefreshTickProvider = StreamProvider.autoDispose
    .family<int, String>((ref, mailboxId) {
      return Stream.periodic(_countRefreshInterval, (tick) => tick);
    });

const _folders = [
  ('inbox', Icons.inbox_outlined, 'Inbox'),
  ('sent', Icons.send_outlined, 'Sent'),
  ('drafts', Icons.drafts_outlined, 'Drafts'),
  ('starred', Icons.star_border, 'Starred'),
  ('important', Icons.label_important_outline, 'Important'),
  ('snoozed', Icons.schedule_outlined, 'Snoozed'),
  ('archive', Icons.archive_outlined, 'Archive'),
  ('spam', Icons.report_outlined, 'Spam'),
  ('trash', Icons.delete_outline, 'Trash'),
];

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formFactor = context.formFactor;
    final mailboxAsync = ref.watch(mailboxListProvider);
    final selectedFolder = ref.watch(selectedFolderProvider);
    final selectedMailboxId = ref.watch(selectedMailboxProvider);

    return mailboxAsync.when(
      loading: () => const Scaffold(body: LoadingWidget()),
      error: (e, _) =>
          Scaffold(body: ErrorDisplay(failure: failureFromError(e))),
      data: (mailboxes) {
        if (mailboxes.isEmpty) {
          return const Scaffold(
            body: EmptyState(
              icon: Icons.inbox_outlined,
              title: 'No mailboxes',
              subtitle: 'Contact your administrator to get access.',
            ),
          );
        }

        // Auto-select first mailbox if none selected.
        final effectiveMailboxId = selectedMailboxId ?? mailboxes.first.id;
        final effectiveMailbox = mailboxes.firstWhere(
          (m) => m.id == effectiveMailboxId,
          orElse: () => mailboxes.first,
        );

        return switch (formFactor) {
          FormFactor.compact => _CompactShell(
            mailboxes: mailboxes,
            selectedMailbox: effectiveMailbox,
            selectedFolder: selectedFolder,
            child: child,
          ),
          FormFactor.medium => _MediumShell(
            mailboxes: mailboxes,
            selectedMailbox: effectiveMailbox,
            selectedFolder: selectedFolder,
            child: child,
          ),
          FormFactor.expanded => _ExpandedShell(
            mailboxes: mailboxes,
            selectedMailbox: effectiveMailbox,
            selectedFolder: selectedFolder,
            child: child,
          ),
        };
      },
    );
  }
}

class _CompactShell extends ConsumerWidget {
  const _CompactShell({
    required this.child,
    required this.mailboxes,
    required this.selectedMailbox,
    required this.selectedFolder,
  });

  final Widget child;
  final List<Mailbox> mailboxes;
  final Mailbox selectedMailbox;
  final String selectedFolder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderIndex = _folders.indexWhere((f) => f.$1 == selectedFolder);
    final currentIndex = folderIndex < 0 ? 0 : folderIndex.clamp(0, 3);
    final counts = _watchLiveThreadCounts(ref, selectedMailbox.id);

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: child),
        ],
      ),
      floatingActionButton: OutboxBadge(
        child: FloatingActionButton(
          onPressed: () => context.push('/compose'),
          tooltip: 'Compose',
          child: const Icon(Icons.edit_outlined),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) {
          ref.read(selectedFolderProvider.notifier).select(_folders[i].$1);
          context.go('/mailbox/${selectedMailbox.id}');
        },
        destinations: _folders.take(4).map((f) {
          return NavigationDestination(
            icon: _CountBadge(
              count: counts?.folders[f.$1] ?? 0,
              child: Icon(f.$2),
            ),
            label: f.$3,
          );
        }).toList(),
      ),
    );
  }
}

class _MediumShell extends ConsumerWidget {
  const _MediumShell({
    required this.child,
    required this.mailboxes,
    required this.selectedMailbox,
    required this.selectedFolder,
  });

  final Widget child;
  final List<Mailbox> mailboxes;
  final Mailbox selectedMailbox;
  final String selectedFolder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderIndex = _folders.indexWhere((f) => f.$1 == selectedFolder);
    final currentIndex = folderIndex < 0 ? 0 : folderIndex;
    final counts = _watchLiveThreadCounts(ref, selectedMailbox.id);

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 20),
                    child: OutboxBadge(
                      child: FilledButton.icon(
                        onPressed: () => context.push('/compose'),
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Compose'),
                      ),
                    ),
                  ),
                  selectedIndex: currentIndex,
                  onDestinationSelected: (i) {
                    ref
                        .read(selectedFolderProvider.notifier)
                        .select(_folders[i].$1);
                    context.go('/mailbox/${selectedMailbox.id}');
                  },
                  destinations: _folders.map((f) {
                    return NavigationRailDestination(
                      icon: _CountBadge(
                        count: counts?.folders[f.$1] ?? 0,
                        child: Icon(f.$2),
                      ),
                      label: Text(f.$3),
                    );
                  }).toList(),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandedShell extends ConsumerWidget {
  const _ExpandedShell({
    required this.child,
    required this.mailboxes,
    required this.selectedMailbox,
    required this.selectedFolder,
  });

  final Widget child;
  final List<Mailbox> mailboxes;
  final Mailbox selectedMailbox;
  final String selectedFolder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 280,
                  child: _DrawerContent(
                    mailboxes: mailboxes,
                    selectedMailbox: selectedMailbox,
                    selectedFolder: selectedFolder,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerContent extends ConsumerWidget {
  const _DrawerContent({
    required this.mailboxes,
    required this.selectedMailbox,
    required this.selectedFolder,
  });

  final List<Mailbox> mailboxes;
  final Mailbox selectedMailbox;
  final String selectedFolder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final labels = ref.watch(labelListProvider(selectedMailbox.id)).value ?? [];
    final counts = _watchLiveThreadCounts(ref, selectedMailbox.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/app_icon.png',
                width: 28,
                height: 28,
              ),
              const SizedBox(width: 8),
              Text('Hedwig', style: theme.textTheme.titleLarge),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: OutboxBadge(
            child: FilledButton.icon(
              onPressed: () => context.push('/compose'),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Compose'),
            ),
          ),
        ),
        if (mailboxes.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: DropdownButton<String>(
              value: selectedMailbox.id,
              isExpanded: true,
              items: mailboxes.map((m) {
                return DropdownMenuItem(
                  value: m.id,
                  child: Text(m.displayName ?? m.emailAddress),
                );
              }).toList(),
              onChanged: (id) {
                if (id != null) {
                  ref.read(selectedMailboxProvider.notifier).select(id);
                  context.go('/mailbox/$id');
                }
              },
            ),
          ),
        _QuotaTile(mailbox: selectedMailbox),
        const Divider(),
        Expanded(
          child: ListView(
            children: [
              ..._folders.map((f) {
                final selected = selectedFolder == f.$1;
                return ListTile(
                  leading: Icon(f.$2),
                  title: Text(f.$3),
                  trailing: _UnreadCountText(counts?.folders[f.$1] ?? 0),
                  selected: selected,
                  onTap: () {
                    ref.read(selectedFolderProvider.notifier).select(f.$1);
                    context.go('/mailbox/${selectedMailbox.id}');
                  },
                );
              }),
              if (labels.isNotEmpty) const Divider(),
              ...labels.map((label) {
                final folder = 'label:${label.name}';
                return ListTile(
                  leading: const Icon(Icons.label_outline),
                  title: Text(label.name),
                  trailing: _UnreadCountText(
                    counts?.labels
                            .where((item) => item.id == label.id)
                            .firstOrNull
                            ?.unread ??
                        0,
                  ),
                  selected: selectedFolder == folder,
                  onTap: () {
                    ref.read(selectedFolderProvider.notifier).select(folder);
                    context.go('/mailbox/${selectedMailbox.id}');
                  },
                );
              }),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () => context.push('/settings'),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sign out'),
          onTap: () => ref.read(authControllerProvider.notifier).logout(),
        ),
      ],
    );
  }
}

ThreadCounts? _watchLiveThreadCounts(WidgetRef ref, String mailboxId) {
  ref.listen(_countRefreshTickProvider(mailboxId), (_, _) {
    ref.invalidate(threadCountsProvider(mailboxId));
  });
  return ref.watch(threadCountsProvider(mailboxId)).value;
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count, required this.child});

  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;
    return Badge(label: Text(count > 99 ? '99+' : '$count'), child: child);
  }
}

class _UnreadCountText extends StatelessWidget {
  const _UnreadCountText(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    return Text(
      count > 999 ? '999+' : '$count',
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}

class _QuotaTile extends StatelessWidget {
  const _QuotaTile({required this.mailbox});

  final Mailbox mailbox;

  @override
  Widget build(BuildContext context) {
    final quota = mailbox.quotaBytes;
    final used = mailbox.usedBytes;
    final hasQuota = quota > 0;
    final progress = hasQuota ? (used / quota).clamp(0.0, 1.0) : 0.0;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_outlined, size: 18),
              const SizedBox(width: 8),
              Text('Storage', style: theme.textTheme.labelLarge),
              const Spacer(),
              Text(
                hasQuota
                    ? '${_formatBytes(used)} / ${_formatBytes(quota)}'
                    : used > 0
                    ? '${_formatBytes(used)} used'
                    : 'No quota set',
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
}
