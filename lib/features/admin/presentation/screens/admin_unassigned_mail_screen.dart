import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/api/paginated_fetch.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:hedwig_client/features/admin/presentation/screens/admin_mailboxes_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_unassigned_mail_screen.g.dart';

/// A recipient address, distinct across every catch-all mailbox's inbound
/// mail, that doesn't match any provisioned mailbox — `resolve_mailbox()`
/// (providers/ingest.py) fell through to the domain's catch-all, so the mail
/// is safely stored but filed under the catch-all mailbox rather than a
/// mailbox of its own. Without this screen the only way to notice was
/// opening each message in the catch-all inbox and expanding its "Delivered-
/// to" header.
class UnassignedAddress {
  UnassignedAddress({
    required this.email,
    required this.domainId,
    required this.catchAllMailboxId,
    required this.catchAllEmailAddress,
    required this.lastSeen,
    this.count = 1,
  });

  final String email;
  final String domainId;
  final String catchAllMailboxId;
  final String catchAllEmailAddress;
  DateTime lastSeen;
  int count;
}

@riverpod
Future<List<UnassignedAddress>> adminUnassignedMail(Ref ref) async {
  final mailboxes = await ref.watch(adminMailboxesProvider.future);
  final catchAlls = mailboxes.where((m) => m.isCatchAll).toList();
  if (catchAlls.isEmpty) return const [];

  final dio = ref.watch(dioClientProvider);
  final byEmail = <String, UnassignedAddress>{};

  for (final mailbox in catchAlls) {
    if (mailbox.domainId == null) continue;
    final rows = await fetchAllPages(
      dio,
      'mail/recipients/',
      (j) => j,
      queryParameters: {
        'delivered_to_mailbox': mailbox.id,
        'page_size': 100,
        'ordering': '-created_at',
      },
    );
    for (final row in rows) {
      final email = (row['email'] as String? ?? '').toLowerCase();
      if (email.isEmpty || email == mailbox.emailAddress.toLowerCase()) {
        // Mail addressed to the catch-all's own literal address — expected,
        // not an unrouted address.
        continue;
      }
      final createdAt =
          DateTime.tryParse(row['created_at'] as String? ?? '') ??
          DateTime.now();
      final existing = byEmail[email];
      if (existing == null) {
        byEmail[email] = UnassignedAddress(
          email: email,
          domainId: mailbox.domainId!,
          catchAllMailboxId: mailbox.id,
          catchAllEmailAddress: mailbox.emailAddress,
          lastSeen: createdAt,
        );
      } else {
        existing.count++;
        if (createdAt.isAfter(existing.lastSeen)) {
          existing.lastSeen = createdAt;
        }
      }
    }
  }

  final result = byEmail.values.toList()
    ..sort((a, b) => b.lastSeen.compareTo(a.lastSeen));
  return result;
}

class AdminUnassignedMailScreen extends ConsumerWidget {
  const AdminUnassignedMailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminUnassignedMailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unassigned mail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(adminUnassignedMailProvider),
          ),
        ],
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (addresses) {
          if (addresses.isEmpty) {
            return const EmptyState(
              icon: Icons.check_circle_outline,
              title: 'Nothing unassigned',
              subtitle:
                  'No inbound mail is addressed to a recipient outside '
                  'your provisioned mailboxes.',
            );
          }
          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, i) {
              final a = addresses[i];
              return ListTile(
                leading: const Icon(
                  Icons.forward_to_inbox_outlined,
                  color: Colors.orange,
                ),
                title: Text(a.email),
                subtitle: Text(
                  '${a.count} message${a.count == 1 ? '' : 's'} · '
                  'landed in ${a.catchAllEmailAddress} · '
                  'last ${_fmt(a.lastSeen)}',
                ),
                trailing: FilledButton.tonal(
                  onPressed: () => _createMailbox(context, ref, a),
                  child: const Text('Create mailbox'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _createMailbox(
    BuildContext context,
    WidgetRef ref,
    UnassignedAddress a,
  ) async {
    final localPart = a.email.split('@').first;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create mailbox?'),
        content: Text(
          'Provision "${a.email}" as a real mailbox? Future mail to it '
          'will be delivered there directly instead of the catch-all — '
          'already-received messages stay in ${a.catchAllEmailAddress}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (ok != true) return;

    try {
      await ref
          .read(dioClientProvider)
          .post(
            'mail/mailboxes/',
            data: {'domain': a.domainId, 'local_part': localPart},
          );
      ref.invalidate(adminMailboxesProvider);
      ref.invalidate(adminUnassignedMailProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Created ${a.email}.')));
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
