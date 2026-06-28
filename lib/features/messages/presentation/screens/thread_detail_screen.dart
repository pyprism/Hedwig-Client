import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/features/labels/data/repositories/label_repository.dart';
import 'package:hedwig_client/features/labels/presentation/controllers/label_controller.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/message_controller.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const _externalImagesPreferenceKey = 'always_show_external_images';

class ThreadDetailScreen extends ConsumerStatefulWidget {
  const ThreadDetailScreen({
    super.key,
    required this.mailboxId,
    required this.threadId,
  });

  final String mailboxId;
  final String threadId;

  @override
  ConsumerState<ThreadDetailScreen> createState() => _ThreadDetailScreenState();
}

class _ThreadDetailScreenState extends ConsumerState<ThreadDetailScreen> {
  final Set<String> _expanded = {};
  final Set<String> _showImagesForMessages = {};
  bool _alwaysShowExternalImages = false;

  @override
  void initState() {
    super.initState();
    _loadExternalImagePreference();
  }

  Future<void> _loadExternalImagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _alwaysShowExternalImages =
          prefs.getBool(_externalImagesPreferenceKey) ?? false;
    });
  }

  Future<void> _setExternalImagePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_externalImagesPreferenceKey, value);
    if (!mounted) return;
    setState(() => _alwaysShowExternalImages = value);
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(threadMessagesProvider(widget.threadId));

    return Scaffold(
      appBar: AppBar(
        title: messagesAsync.maybeWhen(
          data: (msgs) => Text(msgs.isNotEmpty ? msgs.first.subject : 'Thread'),
          orElse: () => const Text('Thread'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.archive_outlined),
            tooltip: 'Archive thread',
            onPressed: () {
              final ids = messagesAsync.valueOrNull?.map((m) => m.id).toList();
              if (ids == null || ids.isEmpty) return;
              ref
                  .read(messageRepositoryProvider)
                  .bulkUpdateState(ids, folder: 'archive');
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Reply',
            onPressed: () => context.push(
              '/compose?reply=${messagesAsync.valueOrNull?.lastOrNull?.id ?? ''}',
            ),
          ),
        ],
      ),
      body: messagesAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => ErrorDisplay(failure: failureFromError(e)),
        data: (messages) {
          if (messages.isEmpty) {
            return const EmptyState(
              icon: Icons.mail_outline,
              title: 'No messages',
            );
          }
          final threadAttachments = _collectDownloadableAttachments(messages);

          // Auto-expand last (latest) message and mark as read.
          if (_expanded.isEmpty) {
            _expanded.add(messages.last.id);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!messages.last.isRead) {
                ref
                    .read(messageStateControllerProvider.notifier)
                    .markRead(messages.last.id, isRead: true);
              }
            });
          }

          return SelectionArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                if (threadAttachments.isNotEmpty)
                  _ThreadAttachmentStrip(
                    attachments: threadAttachments,
                    messageRepository: ref.read(messageRepositoryProvider),
                  ),
                for (final message in messages)
                  _MessageCard(
                    message: message,
                    expanded: _expanded.contains(message.id),
                    showExternalImages:
                        _alwaysShowExternalImages ||
                        _showImagesForMessages.contains(message.id),
                    alwaysShowExternalImages: _alwaysShowExternalImages,
                    onToggle: () => setState(() {
                      if (_expanded.contains(message.id)) {
                        _expanded.remove(message.id);
                      } else {
                        _expanded.add(message.id);
                        if (!message.isRead) {
                          ref
                              .read(messageStateControllerProvider.notifier)
                              .markRead(message.id, isRead: true);
                        }
                      }
                    }),
                    onShowExternalImages: () =>
                        setState(() => _showImagesForMessages.add(message.id)),
                    onExternalImagePreferenceChanged:
                        _setExternalImagePreference,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MessageCard extends ConsumerWidget {
  const _MessageCard({
    required this.message,
    required this.expanded,
    required this.showExternalImages,
    required this.alwaysShowExternalImages,
    required this.onToggle,
    required this.onShowExternalImages,
    required this.onExternalImagePreferenceChanged,
  });

  final MailMessage message;
  final bool expanded;
  final bool showExternalImages;
  final bool alwaysShowExternalImages;
  final VoidCallback onToggle;
  final VoidCallback onShowExternalImages;
  final ValueChanged<bool> onExternalImagePreferenceChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final messageRepository = ref.read(messageRepositoryProvider);
    final hasExternalImages = _hasExternalImages(message.bodyHtml);
    final downloadableAttachments = message.attachments
        .where(
          (attachment) =>
              isDownloadableAttachment(attachment, message.bodyHtml),
        )
        .toList();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            onTap: onToggle,
            title: Text(
              message.fromName ?? message.fromAddress,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              expanded
                  ? message.fromAddress
                  : (message.snippet ?? message.subject),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (message.direction == 'outbound') ...[
                  _StatusChip(status: message.status),
                  const SizedBox(width: 6),
                ],
                if (message.hasAttachments)
                  const Icon(Icons.attach_file, size: 16),
                const SizedBox(width: 4),
                Text(
                  _formatDate(message.receivedAt ?? message.createdAt),
                  style: theme.textTheme.labelSmall,
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(
                    message.isStarred ? Icons.star : Icons.star_border,
                    color: message.isStarred ? Colors.amber : null,
                    size: 20,
                  ),
                  onPressed: () => ref
                      .read(messageStateControllerProvider.notifier)
                      .toggleStar(message.id, starred: !message.isStarred),
                ),
              ],
            ),
          ),
          if (expanded) ...[
            const Divider(height: 1),
            _TrustBanner(message: message),
            _MessageDetails(message: message),
            if (hasExternalImages && !showExternalImages)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Material(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.image_not_supported_outlined),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text('External images are hidden.'),
                        ),
                        TextButton(
                          onPressed: onShowExternalImages,
                          child: const Text('Show images'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: message.bodyHtml != null
                  ? HtmlWidget(
                      message.bodyHtml!,
                      factoryBuilder: () => _InlineImageWidgetFactory(
                        attachments: message.attachments,
                        messageRepository: messageRepository,
                        allowExternalImages: showExternalImages,
                      ),
                    )
                  : SelectableText(
                      message.bodyText ?? message.snippet ?? '(No body)',
                      style: theme.textTheme.bodyMedium,
                    ),
            ),
            if (downloadableAttachments.isNotEmpty)
              _AttachmentList(
                attachments: downloadableAttachments,
                messageRepository: messageRepository,
              ),
            _MessageLabels(message: message),
            _ActionBar(
              message: message,
              showExternalImages: alwaysShowExternalImages,
              onExternalImagePreferenceChanged:
                  onExternalImagePreferenceChanged,
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '';
    final local = dt.toLocal();
    final now = DateTime.now();
    if (local.year == now.year) {
      return DateFormat('MMM d, HH:mm').format(local);
    }
    return DateFormat('MMM d, yyyy HH:mm').format(local);
  }
}

List<Attachment> _collectDownloadableAttachments(List<MailMessage> messages) {
  final seen = <String>{};
  final attachments = <Attachment>[];
  for (final message in messages) {
    for (final attachment in message.attachments) {
      if (!isDownloadableAttachment(attachment, message.bodyHtml) ||
          !seen.add(attachment.id)) {
        continue;
      }
      attachments.add(attachment);
    }
  }
  return attachments;
}

@visibleForTesting
bool isDownloadableAttachment(Attachment attachment, String? bodyHtml) {
  if (!attachment.isInline) return true;
  return !_bodyReferencesAttachment(attachment, bodyHtml);
}

bool _bodyReferencesAttachment(Attachment attachment, String? bodyHtml) {
  final contentId = attachment.contentId;
  if (bodyHtml == null || bodyHtml.isEmpty || contentId == null) {
    return false;
  }

  final normalizedContentId = _normalizeContentId(contentId);
  if (normalizedContentId.isEmpty) return false;

  final cidPattern = RegExp(r'''cid:([^"'\s>)]+)''', caseSensitive: false);
  for (final match in cidPattern.allMatches(bodyHtml)) {
    final cid = match.group(1);
    if (cid != null && _normalizeContentId(cid) == normalizedContentId) {
      return true;
    }
  }
  return false;
}

class _MessageLabels extends ConsumerWidget {
  const _MessageLabels({required this.message});

  final MailMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelsAsync = ref.watch(labelListProvider(message.mailboxId));
    return labelsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (labels) => FutureBuilder<List<String>>(
        future: ref
            .read(labelRepositoryProvider)
            .getMessageLabelIds(message.id),
        builder: (context, snapshot) {
          final applied = snapshot.data?.toSet() ?? {};
          final appliedLabels = labels
              .where((label) => applied.contains(label.id))
              .toList();
          if (appliedLabels.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: appliedLabels.map((label) {
                final color = _labelColor(context, label);
                return Chip(
                  visualDensity: VisualDensity.compact,
                  avatar: Icon(Icons.label, color: color, size: 16),
                  label: Text(label.name),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _AttachmentList extends StatelessWidget {
  const _AttachmentList({
    required this.attachments,
    required this.messageRepository,
  });

  final List<Attachment> attachments;
  final MessageRepository messageRepository;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: attachments
          .map(
            (a) => ListTile(
              dense: true,
              leading: const Icon(Icons.attach_file, size: 18),
              title: Text(
                a.filename,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.download, size: 18),
                onPressed: () async {
                  try {
                    final url = await messageRepository
                        .getAttachmentDownloadUrl(a.id);
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) await launchUrl(uri);
                  } catch (_) {}
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ThreadAttachmentStrip extends StatelessWidget {
  const _ThreadAttachmentStrip({
    required this.attachments,
    required this.messageRepository,
  });

  final List<Attachment> attachments;
  final MessageRepository messageRepository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attachments', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: attachments
                  .map(
                    (attachment) => ActionChip(
                      avatar: const Icon(Icons.attach_file, size: 18),
                      label: Text(attachment.filename),
                      onPressed: () async {
                        try {
                          final url = await messageRepository
                              .getAttachmentDownloadUrl(attachment.id);
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        } catch (_) {}
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Resolves `cid:` image sources (inline attachments referenced from the
/// HTML body) against the message's attachment list, fetching a presigned
/// download URL on demand. Falls back to default handling for normal URLs.
class _InlineImageWidgetFactory extends WidgetFactory {
  _InlineImageWidgetFactory({
    required this.attachments,
    required this.messageRepository,
    required this.allowExternalImages,
  });

  final List<Attachment> attachments;
  final MessageRepository messageRepository;
  final bool allowExternalImages;

  @override
  Widget? buildImageWidget(BuildTree tree, ImageSource src) {
    final url = src.url;
    if (!url.startsWith('cid:')) {
      final uri = Uri.tryParse(url);
      final isExternal =
          uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
      if (isExternal && !allowExternalImages) {
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.image_not_supported_outlined, size: 18),
              SizedBox(width: 8),
              Text('External image hidden'),
            ],
          ),
        );
      }
      return super.buildImageWidget(tree, src);
    }
    final attachment = _findByContentId(attachments, url.substring(4));
    if (attachment == null) return const SizedBox.shrink();
    return _CidImage(
      attachment: attachment,
      messageRepository: messageRepository,
    );
  }

  static Attachment? _findByContentId(
    List<Attachment> attachments,
    String cid,
  ) => findAttachmentByContentId(attachments, cid);
}

@visibleForTesting
Attachment? findAttachmentByContentId(
  List<Attachment> attachments,
  String cid,
) {
  final normalized = _normalizeContentId(cid);
  for (final attachment in attachments) {
    final contentId = attachment.contentId;
    if (contentId != null && _normalizeContentId(contentId) == normalized) {
      return attachment;
    }
  }
  return null;
}

String _normalizeContentId(String value) {
  var normalized = value.trim();
  try {
    normalized = Uri.decodeFull(normalized);
  } catch (_) {}
  normalized = normalized.replaceAll('<', '').replaceAll('>', '');
  if (normalized.toLowerCase().startsWith('cid:')) {
    normalized = normalized.substring(4);
  }
  return normalized.trim();
}

class _CidImage extends StatefulWidget {
  const _CidImage({required this.attachment, required this.messageRepository});

  final Attachment attachment;
  final MessageRepository messageRepository;

  @override
  State<_CidImage> createState() => _CidImageState();
}

class _CidImageState extends State<_CidImage> {
  late final Future<String> _urlFuture = widget.messageRepository
      .getAttachmentDownloadUrl(widget.attachment.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _urlFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Icon(Icons.broken_image_outlined);
        }
        if (!snapshot.hasData) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class _ActionBar extends ConsumerWidget {
  const _ActionBar({
    required this.message,
    required this.showExternalImages,
    required this.onExternalImagePreferenceChanged,
  });

  final MailMessage message;
  final bool showExternalImages;
  final ValueChanged<bool> onExternalImagePreferenceChanged;

  bool get _isCancellableSend =>
      message.direction == 'outbound' &&
      message.status == 'queued' &&
      !message.id.startsWith('local-');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        children: [
          if (_isCancellableSend) ...[
            if (message.scheduledAt != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'Scheduled for ${DateFormat('MMM d, HH:mm').format(message.scheduledAt!.toLocal())}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            TextButton.icon(
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Cancel send'),
              onPressed: () => ref
                  .read(messageStateControllerProvider.notifier)
                  .cancelScheduledSend(message.id),
            ),
          ] else
            Wrap(
              spacing: 4,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.reply),
                  label: const Text('Reply'),
                  onPressed: () => context.push('/compose?reply=${message.id}'),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.reply_all),
                  label: const Text('Reply all'),
                  onPressed: () => context.push(
                    '/compose?reply=${message.id}&mode=replyAll',
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.forward),
                  label: const Text('Forward'),
                  onPressed: () =>
                      context.push('/compose?reply=${message.id}&mode=forward'),
                ),
              ],
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (action) async {
              if (action.startsWith('label:')) {
                await _toggleLabel(context, ref, action.substring(6));
                return;
              }
              if (action == 'show_images_always') {
                onExternalImagePreferenceChanged(true);
                return;
              }
              if (action == 'hide_images_default') {
                onExternalImagePreferenceChanged(false);
                return;
              }
              if (action == 'mark_important') {
                await ref
                    .read(messageRepositoryProvider)
                    .updateState(message.id, isImportant: true);
                return;
              }
              if (action == 'unmark_important') {
                await ref
                    .read(messageRepositoryProvider)
                    .updateState(message.id, isImportant: false);
                return;
              }
              if (action == 'edit_failed') {
                unawaited(
                  context.push('/compose?reply=${message.id}&mode=forward'),
                );
                return;
              }
              if (action == 'copy_body') {
                await Clipboard.setData(
                  ClipboardData(text: _copyableBody(message)),
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message body copied')),
                  );
                }
                return;
              }
              if (action == 'copy_metadata') {
                await Clipboard.setData(
                  ClipboardData(
                    text: const JsonEncoder.withIndent('  ').convert({
                      'id': message.id,
                      'from': message.fromAddress,
                      'reply_to': message.replyTo,
                      'to': message.toAddresses.map((e) => e.toJson()).toList(),
                      'cc': message.ccAddresses.map((e) => e.toJson()).toList(),
                      'bcc': message.bccAddresses
                          .map((e) => e.toJson())
                          .toList(),
                      'subject': message.subject,
                      'status': message.status,
                      'folder': message.folder,
                      'metadata': message.metadata,
                      'raw_headers': message.rawHeaders,
                    }),
                  ),
                );
                return;
              }
              if (action == 'view_original') {
                final url = message.rawMimeUrl;
                if (url != null && url.isNotEmpty) {
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                }
                return;
              }
              if (action == 'restore') {
                await ref.read(messageRepositoryProvider).restore(message.id);
                return;
              }
              if (action == 'permanent_delete') {
                await _permanentDelete(context, ref);
                return;
              }
              if (action == 'snooze') {
                await ref
                    .read(messageStateControllerProvider.notifier)
                    .snooze(
                      message.id,
                      DateTime.now().add(const Duration(days: 1)),
                    );
                return;
              }
              await ref
                  .read(messageStateControllerProvider.notifier)
                  .moveToFolder(message.id, action);
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'archive', child: Text('Archive')),
              const PopupMenuItem(value: 'spam', child: Text('Mark as spam')),
              const PopupMenuItem(value: 'trash', child: Text('Trash')),
              const PopupMenuItem(
                value: 'inbox',
                child: Text('Restore to inbox'),
              ),
              const PopupMenuItem(
                value: 'snooze',
                child: Text('Snooze until tomorrow'),
              ),
              if (message.direction == 'outbound' &&
                  ['failed', 'bounced'].contains(message.status))
                const PopupMenuItem(
                  value: 'edit_failed',
                  child: Text('Edit and resend'),
                ),
              const PopupMenuItem(
                value: 'copy_body',
                child: Text('Copy message body'),
              ),
              const PopupMenuItem(
                value: 'copy_metadata',
                child: Text('Copy message metadata'),
              ),
              PopupMenuItem(
                value: 'view_original',
                enabled:
                    message.rawMimeUrl != null &&
                    message.rawMimeUrl!.isNotEmpty,
                child: const Text('Download original'),
              ),
              PopupMenuItem(
                value: showExternalImages
                    ? 'hide_images_default'
                    : 'show_images_always',
                child: Text(
                  showExternalImages
                      ? 'Hide external images by default'
                      : 'Always show external images',
                ),
              ),
              PopupMenuItem(
                value: _isImportant(message)
                    ? 'unmark_important'
                    : 'mark_important',
                child: Text(
                  _isImportant(message) ? 'Unmark important' : 'Mark important',
                ),
              ),
              if (message.folder == 'spam' || message.folder == 'trash')
                const PopupMenuItem(value: 'restore', child: Text('Restore')),
              if (message.folder == 'trash')
                const PopupMenuItem(
                  value: 'permanent_delete',
                  child: Text('Delete forever'),
                ),
              const PopupMenuDivider(),
              ..._labelMenuItems(ref),
            ],
          ),
        ],
      ),
    );
  }

  List<PopupMenuEntry<String>> _labelMenuItems(WidgetRef ref) {
    final labels = ref.watch(labelListProvider(message.mailboxId)).valueOrNull;
    if (labels == null || labels.isEmpty) {
      return [const PopupMenuItem(enabled: false, child: Text('No labels'))];
    }
    return labels
        .map(
          (label) => PopupMenuItem(
            value: 'label:${label.id}',
            child: Text('Toggle ${label.name}'),
          ),
        )
        .toList();
  }

  Future<void> _toggleLabel(
    BuildContext context,
    WidgetRef ref,
    String labelId,
  ) async {
    final repository = ref.read(labelRepositoryProvider);
    final applied = (await repository.getMessageLabelIds(message.id)).toSet();
    final actions = ref.read(labelActionsProvider.notifier);
    if (applied.contains(labelId)) {
      await actions.removeFromMessage(messageId: message.id, labelId: labelId);
    } else {
      await actions.applyToMessage(messageId: message.id, labelId: labelId);
    }
  }

  Future<void> _permanentDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete forever?'),
        content: const Text('This permanently deletes this message.'),
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
    if (confirm == true) {
      await ref.read(messageRepositoryProvider).permanentDelete(message.id);
    }
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalized = status.toLowerCase();
    final color = switch (normalized) {
      'failed' || 'bounced' || 'spam' => theme.colorScheme.error,
      'delivered' || 'opened' || 'clicked' => Colors.green.shade700,
      'queued' || 'sending' => theme.colorScheme.tertiary,
      _ => theme.colorScheme.primary,
    };
    return Chip(
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: color.withValues(alpha: 0.5)),
      label: Text(_statusLabel(normalized)),
      labelStyle: TextStyle(color: color, fontSize: 12),
    );
  }

  static String _statusLabel(String status) => switch (status) {
    'queued' => 'Queued',
    'sending' => 'Sending',
    'sent' => 'Sent',
    'delivered' => 'Delivered',
    'bounced' => 'Bounced',
    'opened' => 'Opened',
    'clicked' => 'Clicked',
    'spam' => 'Complained',
    'failed' => 'Failed',
    'cancelled' => 'Cancelled',
    _ =>
      status.isEmpty
          ? 'Unknown'
          : '${status[0].toUpperCase()}${status.substring(1)}',
  };
}

class _TrustBanner extends StatelessWidget {
  const _TrustBanner({required this.message});

  final MailMessage message;

  @override
  Widget build(BuildContext context) {
    final warnings = <String>[
      if (_replyToMismatch(message)) 'Reply-to differs from sender',
      if (_hasSuspiciousLinks(message.bodyHtml ?? message.bodyText ?? ''))
        'Suspicious links detected',
      if (_authFailed(message, 'spf')) 'SPF failed',
      if (_authFailed(message, 'dkim')) 'DKIM failed',
      if (_authFailed(message, 'dmarc')) 'DMARC failed',
    ];
    if (warnings.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Material(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  warnings.join(' · '),
                  style: TextStyle(color: theme.colorScheme.onErrorContainer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageDetails extends StatelessWidget {
  const _MessageDetails({required this.message});

  final MailMessage message;

  @override
  Widget build(BuildContext context) {
    final signedBy = _signedBy(message);
    final rows = <(String, String)>[
      ('From', _address(message.fromAddress, message.fromName)),
      if (message.replyTo != null && message.replyTo!.isNotEmpty)
        ('Reply-to', message.replyTo!),
      if (message.envelopeSender != null && message.envelopeSender!.isNotEmpty)
        ('Mailed-by', message.envelopeSender!),
      if (message.envelopeRecipient != null &&
          message.envelopeRecipient!.isNotEmpty)
        ('Delivered-to', message.envelopeRecipient!),
      if (signedBy != null) ('Signed-by', signedBy),
      if (message.toAddresses.isNotEmpty)
        ('To', message.toAddresses.map(_emailAddressLabel).join(', ')),
      if (message.ccAddresses.isNotEmpty)
        ('Cc', message.ccAddresses.map(_emailAddressLabel).join(', ')),
      if (message.bccAddresses.isNotEmpty)
        ('Bcc', message.bccAddresses.map(_emailAddressLabel).join(', ')),
      ('SPF', _authResult(message, 'spf') ?? 'unknown'),
      ('DKIM', _authResult(message, 'dkim') ?? 'unknown'),
      ('DMARC', _authResult(message, 'dmarc') ?? 'unknown'),
    ];

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      title: Wrap(
        spacing: 8,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('Message details'),
          _AuthChip(label: 'SPF', value: _authResult(message, 'spf')),
          _AuthChip(label: 'DKIM', value: _authResult(message, 'dkim')),
          _AuthChip(label: 'DMARC', value: _authResult(message, 'dmarc')),
        ],
      ),
      children: rows
          .map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96,
                    child: Text(
                      row.$1,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Expanded(child: SelectableText(row.$2)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _AuthChip extends StatelessWidget {
  const _AuthChip({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final result = value?.toLowerCase() ?? 'unknown';
    final theme = Theme.of(context);
    final color = switch (result) {
      'pass' || 'passed' => Colors.green.shade700,
      'fail' || 'failed' || 'hardfail' || 'softfail' => theme.colorScheme.error,
      _ => theme.colorScheme.outline,
    };
    return Chip(
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: color.withValues(alpha: 0.5)),
      label: Text('$label ${value ?? 'unknown'}'),
      labelStyle: TextStyle(color: color, fontSize: 12),
    );
  }
}

Color _labelColor(BuildContext context, Label label) {
  final raw = label.color;
  if (raw == null || !raw.startsWith('#') || raw.length != 7) {
    return Theme.of(context).colorScheme.primary;
  }
  return Color(int.parse('0xFF${raw.substring(1)}'));
}

bool _hasExternalImages(String? html) {
  if (html == null || html.isEmpty) return false;
  return RegExp(
    r'''<img[^>]+src=["']https?://''',
    caseSensitive: false,
  ).hasMatch(html);
}

bool _hasSuspiciousLinks(String value) {
  if (value.isEmpty) return false;
  final linkPattern = RegExp(
    r'''<a[^>]+href=["']([^"']+)["'][^>]*>(.*?)</a>''',
    caseSensitive: false,
    dotAll: true,
  );
  for (final match in linkPattern.allMatches(value)) {
    final href = match.group(1) ?? '';
    final label = _stripHtml(match.group(2) ?? '');
    final hrefHost = Uri.tryParse(href)?.host.toLowerCase();
    final labelUri = Uri.tryParse(label.trim());
    final labelHost = labelUri?.hasScheme == true
        ? labelUri?.host.toLowerCase()
        : null;
    if (href.startsWith('http://')) return true;
    if (hrefHost != null &&
        hrefHost.isNotEmpty &&
        labelHost != null &&
        labelHost.isNotEmpty &&
        hrefHost != labelHost) {
      return true;
    }
  }
  return false;
}

bool _replyToMismatch(MailMessage message) {
  final replyTo = message.replyTo?.trim().toLowerCase();
  if (replyTo == null || replyTo.isEmpty) return false;
  return !_emailsFromText(replyTo).contains(message.fromAddress.toLowerCase());
}

bool _isImportant(MailMessage message) {
  final metadata = message.metadata;
  return metadata['is_important'] == true ||
      metadata['importance']?.toString().toLowerCase() == 'high' ||
      _headerValue(message.rawHeaders, 'Importance')?.toLowerCase() == 'high' ||
      _headerValue(message.rawHeaders, 'X-Priority')?.startsWith('1') == true;
}

bool _authFailed(MailMessage message, String key) {
  final value = _authResult(message, key)?.toLowerCase();
  return const {
    'fail',
    'failed',
    'hardfail',
    'softfail',
    'temperror',
  }.contains(value);
}

String? _authResult(MailMessage message, String key) {
  final metadata = message.metadata;
  final candidates = [key, '${key}_result', '${key}_status', key.toUpperCase()];
  for (final candidate in candidates) {
    final value = _mapValue(metadata, candidate);
    if (value != null) return value;
  }

  final auth =
      _mapRawValue(metadata, 'auth_results') ??
      _mapRawValue(metadata, 'authentication_results');
  if (auth is Map) {
    for (final candidate in candidates) {
      final value = _mapValue(auth, candidate);
      if (value != null) return value;
    }
  }

  final header = _headerValue(message.rawHeaders, 'Authentication-Results');
  if (header != null) {
    final match = RegExp(
      '\\b${RegExp.escape(key)}=([a-zA-Z0-9_-]+)',
      caseSensitive: false,
    ).firstMatch(header);
    if (match != null) return match.group(1);
  }

  return _authResultFromSpamTests(message.rawHeaders, key);
}

String? _signedBy(MailMessage message) {
  final direct =
      _stringValue(message.metadata['signed_by']) ??
      _stringValue(message.metadata['dkim_domain']);
  if (direct != null) return direct;
  final dkimSignature = _headerValue(message.rawHeaders, 'DKIM-Signature');
  if (dkimSignature == null) return null;
  return RegExp(
    r'\bd=([^;\s]+)',
    caseSensitive: false,
  ).firstMatch(dkimSignature)?.group(1);
}

String _address(String email, String? name) {
  if (name == null || name.trim().isEmpty) return email;
  return '$name <$email>';
}

String _emailAddressLabel(EmailAddress address) =>
    _address(address.email, address.name);

String _copyableBody(MailMessage message) {
  final text = message.bodyText?.trim();
  if (text != null && text.isNotEmpty) return text;
  final html = message.bodyHtml?.trim();
  if (html != null && html.isNotEmpty) return _stripHtml(html);
  return message.snippet?.trim() ?? '';
}

String _stripHtml(String html) {
  final withBreaks = html
      .replaceAll(RegExp(r'<\s*br\s*/?\s*>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</\s*p\s*>', caseSensitive: false), '\n\n')
      .replaceAll(RegExp(r'</\s*div\s*>', caseSensitive: false), '\n');
  final stripped = withBreaks.replaceAll(RegExp(r'<[^>]+>'), '');
  return _decodeBasicHtmlEntities(
    stripped,
  ).replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
}

String _decodeBasicHtmlEntities(String value) => value
    .replaceAll('&nbsp;', ' ')
    .replaceAll('&amp;', '&')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', "'");

Set<String> _emailsFromText(String text) => RegExp(
  r'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}',
  caseSensitive: false,
).allMatches(text).map((match) => match.group(0)!.toLowerCase()).toSet();

String? _headerValue(Map<String, dynamic> headers, String name) {
  final raw = _mapRawValue(headers, name);
  return _stringValue(raw);
}

String? _mapValue(Map map, String name) =>
    _stringValue(_mapRawValue(map, name));

Object? _mapRawValue(Map map, String name) {
  for (final entry in map.entries) {
    if (entry.key.toString().toLowerCase() == name.toLowerCase()) {
      return entry.value;
    }
  }
  return null;
}

String? _authResultFromSpamTests(Map<String, dynamic> headers, String key) {
  final tests = _headerValue(headers, 'X-Spam-Tests')?.toUpperCase();
  if (tests == null) return null;
  if (key == 'dkim' && tests.contains('DKIM_VALID')) return 'pass';
  if (key == 'spf' && tests.contains('SPF_PASS')) return 'pass';
  if (key == 'spf' && tests.contains('SPF_FAIL')) return 'fail';
  return null;
}

String? _stringValue(Object? value) {
  if (value == null) return null;
  if (value is String) return value.trim().isEmpty ? null : value.trim();
  if (value is Map) {
    for (final key in const ['result', 'status', 'value', 'domain']) {
      final nested = _stringValue(value[key]);
      if (nested != null) return nested;
    }
  }
  return value.toString();
}
