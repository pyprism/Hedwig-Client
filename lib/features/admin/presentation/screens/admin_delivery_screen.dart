import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/widgets/empty_state.dart';
import 'package:hedwig_client/core/widgets/loading_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_delivery_screen.g.dart';

class DeliveryEvent {
  const DeliveryEvent({
    required this.id,
    required this.eventType,
    required this.occurredAt,
    this.recipient,
    this.reason,
  });

  final String id;
  final String eventType;
  final DateTime occurredAt;
  final String? recipient;
  final String? reason;

  factory DeliveryEvent.fromJson(Map<String, dynamic> j) => DeliveryEvent(
    id: j['id'] as String,
    eventType: j['event_type'] as String? ?? '',
    occurredAt:
        DateTime.tryParse(j['occurred_at'] as String? ?? '') ?? DateTime.now(),
    recipient: j['recipient'] as String?,
    reason: j['reason'] as String?,
  );
}

@riverpod
Future<List<DeliveryEvent>> adminDeliveryEvents(Ref ref) async {
  final res = await ref
      .watch(dioClientProvider)
      .get(
        'providers/delivery-events/',
        queryParameters: {'page_size': 50, 'ordering': '-occurred_at'},
      );
  return (res.data['results'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(DeliveryEvent.fromJson)
      .toList();
}

class AdminDeliveryScreen extends ConsumerWidget {
  const AdminDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(adminDeliveryEventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(adminDeliveryEventsProvider),
          ),
        ],
      ),
      body: async.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (events) {
          if (events.isEmpty) {
            return const EmptyState(
              icon: Icons.track_changes,
              title: 'No delivery events',
            );
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, i) {
              final e = events[i];
              final (icon, color) = _iconForEvent(e.eventType);
              return ListTile(
                leading: Icon(icon, color: color, size: 20),
                title: Text(e.eventType.toUpperCase()),
                subtitle: Text(e.recipient ?? ''),
                trailing: Text(
                  _fmt(e.occurredAt),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                onTap: e.reason != null
                    ? () => showDialog<void>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(e.eventType),
                          content: Text(e.reason!),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  (IconData, Color) _iconForEvent(String type) => switch (type) {
    'delivered' => (Icons.check_circle, Colors.green),
    'bounced' => (Icons.error, Colors.red),
    'complained' => (Icons.report, Colors.orange),
    'opened' => (Icons.open_in_new, Colors.blue),
    'clicked' => (Icons.touch_app, Colors.blue),
    'failed' => (Icons.cancel, Colors.red),
    _ => (Icons.info_outline, Colors.grey),
  };

  String _fmt(DateTime dt) {
    final d = dt.toLocal();
    return '${d.month}/${d.day} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }
}
