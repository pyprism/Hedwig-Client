import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_watcher.g.dart';

@Riverpod(keepAlive: true)
Stream<List<ConnectivityResult>> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

@Riverpod(keepAlive: true)
Stream<bool> isOnline(Ref ref) async* {
  await for (final results in Connectivity().onConnectivityChanged) {
    yield results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }
}
