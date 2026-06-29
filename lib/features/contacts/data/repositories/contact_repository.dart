import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/contacts/data/datasources/contact_remote_datasource.dart';
import 'package:hedwig_client/shared/models/contact.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_repository.g.dart';

@Riverpod(keepAlive: true)
ContactRepository contactRepository(Ref ref) {
  return ContactRepository(
    remote: ContactRemoteDatasource(ref.watch(dioClientProvider)),
    db: ref.watch(appDatabaseProvider),
  );
}

class ContactRepository {
  const ContactRepository({required this.remote, required this.db});

  final ContactRemoteDatasource remote;
  final AppDatabase db;

  Stream<List<Contact>> watchContacts(String mailboxId) {
    _refresh(mailboxId);
    return db.contactDao
        .watchByMailbox(mailboxId)
        .map((rows) => rows.map(_rowToModel).toList());
  }

  Future<void> _refresh(String mailboxId) async {
    try {
      final contacts = await remote.getContacts(mailboxId: mailboxId);
      await db.contactDao.upsertAll(contacts.map(_modelToRow).toList());
    } catch (_) {}
  }

  Future<List<String>> searchEmails(String query) async {
    try {
      final contacts = await remote.getContacts(mailboxId: '', search: query);
      return contacts.map((c) => c.email).toList();
    } catch (_) {
      return [];
    }
  }

  Future<Contact> create({
    required String mailboxId,
    required String email,
    String? name,
  }) async {
    final contact = await remote.createContact(
      mailboxId: mailboxId,
      email: email,
      name: name,
    );
    await db.contactDao.upsertAll([_modelToRow(contact)]);
    return contact;
  }

  Future<Contact> toggleFavorite(Contact contact) async {
    final updated = await remote.updateContact(
      contact.id,
      isFavorite: !contact.isFavorite,
    );
    await db.contactDao.upsertAll([_modelToRow(updated)]);
    return updated;
  }

  Future<Contact> update(Contact contact, {String? name}) async {
    final updated = await remote.updateContact(contact.id, name: name);
    await db.contactDao.upsertAll([_modelToRow(updated)]);
    return updated;
  }

  Future<void> delete(String id) async {
    await remote.deleteContact(id);
    // Remove from local cache will happen on next refresh.
  }

  Contact _rowToModel(ContactRow r) => Contact(
    id: r.id,
    mailboxId: r.mailboxId,
    email: r.email,
    name: r.name,
    isFavorite: r.isFavorite,
    timesContacted: r.timesContacted,
    lastContactedAt: r.lastContactedAt,
    updatedAt: r.updatedAt,
  );

  ContactsCompanion _modelToRow(Contact c) => ContactsCompanion.insert(
    id: c.id,
    mailboxId: c.mailboxId,
    email: c.email,
    name: Value(c.name),
    isFavorite: Value(c.isFavorite),
    timesContacted: Value(c.timesContacted),
    lastContactedAt: Value(c.lastContactedAt),
    updatedAt: c.updatedAt ?? DateTime.now().toUtc(),
  );
}
