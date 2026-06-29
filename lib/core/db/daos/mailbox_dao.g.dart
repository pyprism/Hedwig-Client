// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_dao.dart';

// ignore_for_file: type=lint
mixin _$MailboxDaoMixin on DatabaseAccessor<AppDatabase> {
  $MailboxesTable get mailboxes => attachedDatabase.mailboxes;
  MailboxDaoManager get managers => MailboxDaoManager(this);
}

class MailboxDaoManager {
  final _$MailboxDaoMixin _db;
  MailboxDaoManager(this._db);
  $$MailboxesTableTableManager get mailboxes =>
      $$MailboxesTableTableManager(_db.attachedDatabase, _db.mailboxes);
}
