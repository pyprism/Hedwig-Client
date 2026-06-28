import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/sync/connectivity_watcher.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);
    final isOffline = connectivity.when(
      data: (list) => list.contains(ConnectivityResult.none) || list.isEmpty,
      loading: () => false,
      error: (_, stack) => false,
    );

    if (!isOffline) return const SizedBox.shrink();

    return MaterialBanner(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      content: const Text('No connection — showing cached data'),
      leading: const Icon(Icons.cloud_off, size: 20),
      actions: const [SizedBox.shrink()],
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      contentTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onErrorContainer,
      ),
    );
  }
}
