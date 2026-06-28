import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/features/contacts/data/repositories/contact_repository.dart';
import 'package:hedwig_client/shared/models/contact.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_controller.g.dart';

@riverpod
Stream<List<Contact>> contactList(Ref ref, String mailboxId) {
  return ref.watch(contactRepositoryProvider).watchContacts(mailboxId);
}

@riverpod
class ContactActions extends _$ContactActions {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> create({
    required String mailboxId,
    required String email,
    String? name,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(contactRepositoryProvider)
          .create(mailboxId: mailboxId, email: email, name: name),
    );
  }

  Future<void> toggleFavorite(Contact contact) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(contactRepositoryProvider).toggleFavorite(contact),
    );
  }

  Future<void> update(Contact contact, {String? name}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(contactRepositoryProvider).update(contact, name: name),
    );
  }

  Future<void> delete(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(contactRepositoryProvider).delete(id),
    );
  }
}
