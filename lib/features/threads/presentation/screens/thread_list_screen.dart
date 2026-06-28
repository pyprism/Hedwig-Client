import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/skeleton_loader.dart';
import 'package:hedwig_client/features/labels/data/repositories/label_repository.dart';
import 'package:hedwig_client/features/labels/presentation/controllers/label_controller.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/features/threads/data/repositories/thread_repository.dart';
import 'package:hedwig_client/features/threads/presentation/controllers/thread_controller.dart';
import 'package:hedwig_client/shared/models/thread.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ComposeIntent extends Intent {
  const _ComposeIntent();
}

class _SearchIntent extends Intent {
  const _SearchIntent();
}

class _RefreshIntent extends Intent {
  const _RefreshIntent();
}

class _ArchiveIntent extends Intent {
  const _ArchiveIntent();
}

class _MarkReadIntent extends Intent {
  const _MarkReadIntent();
}

class _StarIntent extends Intent {
  const _StarIntent();
}

class ThreadListScreen extends ConsumerStatefulWidget {
  const ThreadListScreen({
    super.key,
    required this.mailboxId,
    this.onThreadTap,
    this.selectedThreadId,
  });

  final String mailboxId;
  final void Function(MailThread thread)? onThreadTap;
  final String? selectedThreadId;

  @override
  ConsumerState<ThreadListScreen> createState() => _ThreadListScreenState();
}

class _ThreadListScreenState extends ConsumerState<ThreadListScreen> {
  String? _search;
  int _page = 1;
  bool _loadingMore = false;
  final Set<String> _selectedThreadIds = {};
  String _density = 'comfortable';
  final _searchCtrl = TextEditingController();
  final _searchFocusNode = FocusNode();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
    _searchFocusNode.addListener(_onSearchFocusChanged);
    _loadPreferences();
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onSearchFocusChanged);
    _searchCtrl.dispose();
    _searchFocusNode.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onSearchFocusChanged() {
    setState(() {});
  }

  void _onScroll() {
    if (_loadingMore) return;
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 200) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNextPage() async {
    if (_loadingMore) return;
    setState(() => _loadingMore = true);
    final folder = ref.read(selectedFolderProvider);
    await ref
        .read(threadRepositoryProvider)
        .fetchNextPage(
          mailboxId: widget.mailboxId,
          folder: folder,
          page: _page + 1,
          search: _search,
        );
    setState(() {
      _page++;
      _loadingMore = false;
    });
  }

  Future<void> _markThreadRead(MailThread thread) async {
    if (!thread.hasUnread) return;
    await ref.read(messageRepositoryProvider).markThreadRead(thread.id);
    ref.invalidate(threadCountsProvider(widget.mailboxId));
  }

  void _openThread(MailThread thread) {
    if (ref.read(selectedFolderProvider) == 'drafts') {
      context.push('/compose?draft=${Uri.encodeComponent(thread.id)}');
      return;
    }
    if (thread.hasUnread) {
      unawaited(_markThreadRead(thread));
    }
    final handler = widget.onThreadTap;
    if (handler != null) {
      handler(thread);
    } else {
      context.push('/mailbox/${thread.mailboxId}/thread/${thread.id}');
    }
  }

  Future<void> _bulkUpdateSelected({
    bool? isRead,
    bool? isStarred,
    String? folder,
  }) async {
    if (_selectedThreadIds.isEmpty) return;
    final repository = ref.read(messageRepositoryProvider);
    final messageIds = <String>[];
    for (final threadId in _selectedThreadIds) {
      final messages = await repository.getThreadMessages(threadId);
      messageIds.addAll(messages.map((message) => message.id));
    }
    await repository.bulkUpdateState(
      messageIds,
      isRead: isRead,
      isStarred: isStarred,
      folder: folder,
    );
    if (mounted && folder != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Moved ${_selectedThreadIds.length} thread(s).'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () =>
                repository.bulkUpdateState(messageIds, folder: 'inbox'),
          ),
        ),
      );
    }
    setState(_selectedThreadIds.clear);
    ref.invalidate(threadListProvider);
  }

  Future<void> _bulkRestoreSelected() async {
    if (_selectedThreadIds.isEmpty) return;
    final repository = ref.read(messageRepositoryProvider);
    for (final threadId in _selectedThreadIds) {
      final messages = await repository.getThreadMessages(threadId);
      for (final message in messages) {
        await repository.restore(message.id);
      }
    }
    setState(_selectedThreadIds.clear);
    ref.invalidate(threadListProvider);
  }

  Future<void> _bulkPermanentDeleteSelected() async {
    if (_selectedThreadIds.isEmpty) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete forever?'),
        content: const Text('This permanently deletes the selected messages.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete forever'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final repository = ref.read(messageRepositoryProvider);
    for (final threadId in _selectedThreadIds) {
      final messages = await repository.getThreadMessages(threadId);
      for (final message in messages) {
        await repository.permanentDelete(message.id);
      }
    }
    setState(_selectedThreadIds.clear);
    ref.invalidate(threadListProvider);
  }

  Future<void> _bulkToggleLabel(String labelId) async {
    if (_selectedThreadIds.isEmpty) return;
    final messageRepository = ref.read(messageRepositoryProvider);
    final labelRepository = ref.read(labelRepositoryProvider);
    final appliedNow = <String>[];
    final removedNow = <String>[];
    for (final threadId in _selectedThreadIds) {
      final messages = await messageRepository.getThreadMessages(threadId);
      for (final message in messages) {
        final applied = (await labelRepository.getMessageLabelIds(
          message.id,
        )).toSet();
        if (applied.contains(labelId)) {
          await labelRepository.removeFromMessage(
            messageId: message.id,
            labelId: labelId,
          );
          removedNow.add(message.id);
        } else {
          await labelRepository.applyToMessage(
            messageId: message.id,
            labelId: labelId,
          );
          appliedNow.add(message.id);
        }
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Label changes applied.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              for (final messageId in appliedNow) {
                unawaited(
                  labelRepository.removeFromMessage(
                    messageId: messageId,
                    labelId: labelId,
                  ),
                );
              }
              for (final messageId in removedNow) {
                unawaited(
                  labelRepository.applyToMessage(
                    messageId: messageId,
                    labelId: labelId,
                  ),
                );
              }
            },
          ),
        ),
      );
    }
    setState(_selectedThreadIds.clear);
    ref.invalidate(threadListProvider);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _density = prefs.getString('message_density') ?? 'comfortable';
    });
  }

  Future<void> _submitSearch(String value) async {
    final search = value.trim();
    setState(() {
      _search = search.isEmpty ? null : search;
      _page = 1;
    });
  }

  void _archiveFocusedSelection() {
    if (_selectedThreadIds.isNotEmpty) {
      _bulkUpdateSelected(folder: 'archive');
    }
  }

  void _markFocusedSelectionRead() {
    if (_selectedThreadIds.isNotEmpty) {
      _bulkUpdateSelected(isRead: true);
    }
  }

  void _starFocusedSelection() {
    if (_selectedThreadIds.isNotEmpty) {
      _bulkUpdateSelected(isStarred: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final folder = ref.watch(selectedFolderProvider);
    final labels =
        ref.watch(labelListProvider(widget.mailboxId)).valueOrNull ?? [];
    final threadsAsync = ref.watch(
      threadListProvider(
        mailboxId: widget.mailboxId,
        folder: folder,
        search: _search,
      ),
    );

    return Shortcuts(
      shortcuts: threadListShortcuts(
        textInputFocused: _searchFocusNode.hasFocus,
      ),
      child: Actions(
        actions: {
          _ComposeIntent: CallbackAction<_ComposeIntent>(
            onInvoke: (_) => context.push('/compose'),
          ),
          _SearchIntent: CallbackAction<_SearchIntent>(
            onInvoke: (_) {
              _searchFocusNode.requestFocus();
              return null;
            },
          ),
          _RefreshIntent: CallbackAction<_RefreshIntent>(
            onInvoke: (_) {
              ref.invalidate(threadListProvider);
              return null;
            },
          ),
          _ArchiveIntent: CallbackAction<_ArchiveIntent>(
            onInvoke: (_) {
              _archiveFocusedSelection();
              return null;
            },
          ),
          _MarkReadIntent: CallbackAction<_MarkReadIntent>(
            onInvoke: (_) {
              _markFocusedSelectionRead();
              return null;
            },
          ),
          _StarIntent: CallbackAction<_StarIntent>(
            onInvoke: (_) {
              _starFocusedSelection();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: AppBar(
              title: Semantics(
                header: true,
                child: Text(
                  _selectedThreadIds.isEmpty
                      ? _folderLabel(folder)
                      : '${_selectedThreadIds.length} selected',
                ),
              ),
              actions: [
                if (_selectedThreadIds.isNotEmpty) ...[
                  IconButton(
                    tooltip: 'Archive',
                    icon: const Icon(Icons.archive_outlined),
                    onPressed: () => _bulkUpdateSelected(folder: 'archive'),
                  ),
                  IconButton(
                    tooltip: 'Mark read',
                    icon: const Icon(Icons.mark_email_read_outlined),
                    onPressed: () => _bulkUpdateSelected(isRead: true),
                  ),
                  IconButton(
                    tooltip: 'Star',
                    icon: const Icon(Icons.star_border),
                    onPressed: () => _bulkUpdateSelected(isStarred: true),
                  ),
                  IconButton(
                    tooltip: 'Trash',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _bulkUpdateSelected(folder: 'trash'),
                  ),
                  IconButton(
                    tooltip: 'Spam',
                    icon: const Icon(Icons.report_outlined),
                    onPressed: () => _bulkUpdateSelected(folder: 'spam'),
                  ),
                  if (folder == 'spam' || folder == 'trash')
                    IconButton(
                      tooltip: 'Restore',
                      icon: const Icon(Icons.restore_from_trash_outlined),
                      onPressed: _bulkRestoreSelected,
                    ),
                  if (folder == 'trash')
                    IconButton(
                      tooltip: 'Delete forever',
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: _bulkPermanentDeleteSelected,
                    ),
                  if (labels.isNotEmpty)
                    PopupMenuButton<String>(
                      tooltip: 'Toggle label',
                      icon: const Icon(Icons.label_outline),
                      onSelected: _bulkToggleLabel,
                      itemBuilder: (_) => labels
                          .map(
                            (label) => PopupMenuItem(
                              value: label.id,
                              child: Text(label.name),
                            ),
                          )
                          .toList(),
                    ),
                  IconButton(
                    tooltip: 'Clear selection',
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(_selectedThreadIds.clear),
                  ),
                ],
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: Semantics(
                    label: 'Search messages',
                    child: SearchBar(
                      controller: _searchCtrl,
                      focusNode: _searchFocusNode,
                      hintText: 'Search… (press / to focus)',
                      leading: const Icon(Icons.search),
                      trailing: [
                        if (_search != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: 'Clear search',
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() => _search = null);
                            },
                          ),
                      ],
                      onSubmitted: _submitSearch,
                    ),
                  ),
                ),
              ),
            ),
            body: threadsAsync.when(
              loading: () => const ThreadListSkeleton(),
              error: (e, _) => ErrorDisplay(
                failure: failureFromError(e),
                onRetry: () => ref.invalidate(threadListProvider),
              ),
              data: (threads) {
                if (threads.isEmpty) {
                  return EmptyState(
                    icon: Icons.inbox_outlined,
                    title: 'Nothing here',
                    subtitle: _search != null
                        ? 'No results for "$_search"'
                        : 'No messages in ${_folderLabel(folder).toLowerCase()}.',
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() => _page = 1);
                    ref.invalidate(threadListProvider);
                  },
                  child: Semantics(
                    label: 'Thread list',
                    child: ListView.separated(
                      controller: _scrollCtrl,
                      itemCount: threads.length + (_loadingMore ? 1 : 0),
                      separatorBuilder: (_, index) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        if (i == threads.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _ThreadTile(
                          thread: threads[i],
                          onTap: _openThread,
                          selected: widget.selectedThreadId == threads[i].id,
                          selectionMode: _selectedThreadIds.isNotEmpty,
                          checked: _selectedThreadIds.contains(threads[i].id),
                          onSelectionChanged: (selected) => setState(() {
                            if (selected) {
                              _selectedThreadIds.add(threads[i].id);
                            } else {
                              _selectedThreadIds.remove(threads[i].id);
                            }
                          }),
                          density: _density,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _folderLabel(String folder) => switch (folder) {
    'inbox' => 'Inbox',
    'sent' => 'Sent',
    'drafts' => 'Drafts',
    'starred' => 'Starred',
    'important' => 'Important',
    'snoozed' => 'Snoozed',
    'archive' => 'Archive',
    'spam' => 'Spam',
    'trash' => 'Trash',
    final f when f.startsWith('label:') => f.substring(6),
    _ => folder,
  };
}

@visibleForTesting
Map<ShortcutActivator, Intent> threadListShortcuts({
  required bool textInputFocused,
}) {
  if (textInputFocused) return const {};
  return {
    LogicalKeySet(LogicalKeyboardKey.keyC): const _ComposeIntent(),
    LogicalKeySet(LogicalKeyboardKey.slash): const _SearchIntent(),
    LogicalKeySet(LogicalKeyboardKey.keyR): const _RefreshIntent(),
    LogicalKeySet(LogicalKeyboardKey.keyE): const _ArchiveIntent(),
    LogicalKeySet(LogicalKeyboardKey.keyM): const _MarkReadIntent(),
    LogicalKeySet(LogicalKeyboardKey.keyS): const _StarIntent(),
  };
}

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({
    required this.thread,
    this.onTap,
    this.selected = false,
    this.selectionMode = false,
    this.checked = false,
    this.onSelectionChanged,
    this.density = 'comfortable',
  });

  final MailThread thread;
  final void Function(MailThread)? onTap;
  final bool selected;
  final bool selectionMode;
  final bool checked;
  final ValueChanged<bool>? onSelectionChanged;
  final String density;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unread = thread.hasUnread;
    final textStyle = unread
        ? theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          )
        : theme.textTheme.bodyMedium;

    void handleTap() {
      if (selectionMode) {
        onSelectionChanged?.call(!checked);
        return;
      }
      if (onTap != null) {
        onTap!(thread);
      } else {
        context.push('/mailbox/${thread.mailboxId}/thread/${thread.id}');
      }
    }

    return Semantics(
      button: true,
      label:
          '${unread ? 'Unread. ' : ''}${thread.participants.take(2).join(', ')}. ${thread.subject}. ${_formatDate(thread.lastMessageAt)}',
      child: ListTile(
        visualDensity: switch (density) {
          'compact' => VisualDensity.compact,
          'relaxed' => VisualDensity.standard,
          _ => VisualDensity.comfortable,
        },
        onTap: handleTap,
        onLongPress: () => onSelectionChanged?.call(true),
        selected: selected,
        leading: ExcludeSemantics(
          child: selectionMode
              ? Checkbox(
                  value: checked,
                  onChanged: (value) =>
                      onSelectionChanged?.call(value ?? false),
                )
              : Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: unread
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primaryContainer,
                      child: Text(
                        thread.participants.isNotEmpty
                            ? thread.participants.first
                                  .substring(0, 1)
                                  .toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: unread
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onPrimaryContainer,
                          fontWeight: unread ? FontWeight.w800 : null,
                        ),
                      ),
                    ),
                    if (unread)
                      Positioned(
                        right: -1,
                        top: -1,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        title: Text(
          thread.participants.take(2).join(', '),
          style: textStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _subjectLine(thread),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: unread
                  ? TextStyle(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface,
                    )
                  : null,
            ),
            if (_previewLine(thread).isNotEmpty)
              Text(
                _previewLine(thread),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (thread.labels.isNotEmpty || thread.hasAttachments)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...thread.labels
                        .take(3)
                        .map(
                          (label) => Chip(
                            visualDensity: VisualDensity.compact,
                            avatar: Icon(
                              Icons.label,
                              size: 14,
                              color: _threadLabelColor(context, label),
                            ),
                            label: Text(label.name),
                          ),
                        ),
                    if (thread.hasAttachments)
                      Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: const Icon(Icons.attach_file, size: 14),
                        label: Text(
                          thread.attachmentFilenames.isEmpty
                              ? 'Attachment'
                              : thread.attachmentFilenames.first,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatDate(thread.lastMessageAt),
              style: theme.textTheme.labelSmall?.copyWith(
                color: unread ? theme.colorScheme.primary : null,
                fontWeight: unread ? FontWeight.w800 : null,
              ),
            ),
            if (thread.messageCount > 1)
              Text(
                thread.unreadCount > 0
                    ? '${thread.unreadCount}/${thread.messageCount}'
                    : '${thread.messageCount}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: unread
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.outline,
                  fontWeight: unread ? FontWeight.w800 : null,
                  backgroundColor: unread ? theme.colorScheme.primary : null,
                ),
              ),
          ],
        ),
        tileColor: unread
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.24)
            : null,
      ),
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '';
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    if (diff.inDays < 7) {
      return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][dt.weekday - 1];
    }
    return '${dt.day}/${dt.month}';
  }

  String _subjectLine(MailThread thread) {
    final prefix = thread.latestDirection == 'outbound' ? 'To: ' : '';
    return '$prefix${thread.subject}';
  }

  String _previewLine(MailThread thread) {
    final highlight = thread.searchHighlight?.trim();
    if (highlight != null && highlight.isNotEmpty) return highlight;
    return thread.snippet?.trim() ?? '';
  }
}

Color _threadLabelColor(BuildContext context, ThreadLabel label) {
  final raw = label.color;
  if (raw == null || !raw.startsWith('#') || raw.length != 7) {
    return Theme.of(context).colorScheme.primary;
  }
  return Color(int.parse('0xFF${raw.substring(1)}'));
}
