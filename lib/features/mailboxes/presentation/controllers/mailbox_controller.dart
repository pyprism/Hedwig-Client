import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/features/mailboxes/data/repositories/mailbox_repository.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mailbox_controller.g.dart';

@riverpod
Stream<List<Mailbox>> mailboxList(Ref ref) {
  return ref.watch(mailboxRepositoryProvider).watchMailboxes();
}

/// The currently selected mailbox id.
@Riverpod(keepAlive: true)
class SelectedMailbox extends _$SelectedMailbox {
  @override
  String? build() => null;

  void select(String id) => state = id;
}

/// The currently selected folder name.
@Riverpod(keepAlive: true)
class SelectedFolder extends _$SelectedFolder {
  @override
  String build() => 'inbox';

  void select(String folder) => state = folder;
}
