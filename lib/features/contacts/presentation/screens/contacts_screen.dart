import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/error_display.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/features/contacts/presentation/controllers/contact_controller.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/shared/models/contact.dart';

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final mailboxId = ref.watch(selectedMailboxProvider);
    if (mailboxId == null) {
      return const Scaffold(body: LoadingWidget());
    }

    final contactsAsync = ref.watch(contactListProvider(mailboxId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: SearchBar(
              hintText: 'Search contacts...',
              leading: const Icon(Icons.search),
              onChanged: (v) => setState(() => _search = v.toLowerCase()),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, mailboxId),
        child: const Icon(Icons.person_add),
      ),
      body: contactsAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => ErrorDisplay(failure: failureFromError(e)),
        data: (contacts) {
          final filtered = _search.isEmpty
              ? contacts
              : contacts
                    .where(
                      (c) =>
                          c.email.toLowerCase().contains(_search) ||
                          (c.name?.toLowerCase().contains(_search) ?? false),
                    )
                    .toList();

          if (filtered.isEmpty) {
            return const EmptyState(
              icon: Icons.people_outline,
              title: 'No contacts',
              subtitle:
                  'Add contacts to auto-complete addresses when composing.',
            );
          }

          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, i) => _ContactTile(contact: filtered[i]),
          );
        },
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, String mailboxId) async {
    final emailCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name (optional)'),
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
                  .read(contactActionsProvider.notifier)
                  .create(
                    mailboxId: mailboxId,
                    email: emailCtrl.text.trim(),
                    name: nameCtrl.text.trim().isEmpty
                        ? null
                        : nameCtrl.text.trim(),
                  );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
    emailCtrl.dispose();
    nameCtrl.dispose();
  }
}

class _ContactTile extends ConsumerWidget {
  const _ContactTile({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final initials =
        (contact.name?.isNotEmpty == true ? contact.name! : contact.email)
            .substring(0, 1)
            .toUpperCase();

    return ListTile(
      onTap: () => _showContactCard(context, ref),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(
          initials,
          style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
        ),
      ),
      title: Text(contact.name ?? contact.email),
      subtitle: contact.name != null ? Text(contact.email) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Compose',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push(
              '/compose?to=${Uri.encodeComponent(contact.email)}',
            ),
          ),
          IconButton(
            icon: Icon(
              contact.isFavorite ? Icons.star : Icons.star_border,
              color: contact.isFavorite ? Colors.amber : null,
            ),
            onPressed: () => ref
                .read(contactActionsProvider.notifier)
                .toggleFavorite(contact),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'edit') {
                _showEditDialog(context, ref);
              }
              if (v == 'delete') {
                ref.read(contactActionsProvider.notifier).delete(contact.id);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showContactCard(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              child: Text((contact.name ?? contact.email)[0].toUpperCase()),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(contact.name ?? contact.email)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(contact.email),
            const SizedBox(height: 12),
            Text('Messages: ${contact.timesContacted}'),
            if (contact.lastContactedAt != null)
              Text('Last contact: ${contact.lastContactedAt!.toLocal()}'),
            const SizedBox(height: 12),
            Row(
              children: [
                FilterChip(
                  selected: contact.isFavorite,
                  avatar: const Icon(Icons.star, size: 18),
                  label: const Text('Favorite'),
                  onSelected: (_) {
                    ref
                        .read(contactActionsProvider.notifier)
                        .toggleFavorite(contact);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _showEditDialog(context, ref);
            },
            child: const Text('Edit'),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Compose'),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.push('/compose?to=${Uri.encodeComponent(contact.email)}');
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController(text: contact.name ?? '');
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit contact'),
        content: TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: 'Name'),
          autofocus: true,
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
                  .read(contactActionsProvider.notifier)
                  .update(
                    contact,
                    name: nameCtrl.text.trim().isEmpty
                        ? null
                        : nameCtrl.text.trim(),
                  );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    nameCtrl.dispose();
  }
}
