// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_dao.dart';

// ignore_for_file: type=lint
mixin _$ThreadDaoMixin on DatabaseAccessor<AppDatabase> {
  $ThreadsTable get threads => attachedDatabase.threads;
  ThreadDaoManager get managers => ThreadDaoManager(this);
}

class ThreadDaoManager {
  final _$ThreadDaoMixin _db;
  ThreadDaoManager(this._db);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db.attachedDatabase, _db.threads);
}
