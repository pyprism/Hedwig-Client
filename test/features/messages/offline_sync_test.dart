import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/core/sync/connectivity_watcher.dart';
import 'package:hedwig_client/core/sync/sync_engine.dart';
import 'package:hedwig_client/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/compose_controller.dart';
import 'package:hedwig_client/features/threads/data/datasources/thread_remote_datasource.dart';
import 'package:hedwig_client/features/threads/data/repositories/thread_repository.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';
import 'package:hedwig_client/shared/models/thread.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements MessageRemoteDatasource {}

class _MockThreadRemote extends Mock implements ThreadRemoteDatasource {}

class _MockDio extends Mock implements Dio {}

AppDatabase _memoryDb() => AppDatabase.forTesting(NativeDatabase.memory());

Future<void> _seedMessage(
  AppDatabase db, {
  required String id,
  String folder = 'inbox',
}) => db.messageDao.upsertAll([
  MessagesCompanion.insert(
    id: id,
    mailboxId: 'mb1',
    direction: 'inbound',
    status: 'received',
    fromAddress: 'sender@example.com',
    subject: 'Hello',
    folder: Value(folder),
    createdAt: DateTime.now().toUtc(),
  ),
]);

void main() {
  setUpAll(() {
    registerFallbackValue(<String>['x']);
  });

  group('MessageRepository offline write paths', () {
    late AppDatabase db;
    late _MockRemote remote;
    late MessageRepository repo;

    setUp(() {
      db = _memoryDb();
      remote = _MockRemote();
      repo = MessageRepository(remote: remote, db: db);
    });

    tearDown(() => db.close());

    test(
      'bulkUpdateState enqueues one state_change per id when remote throws (A1)',
      () async {
        await _seedMessage(db, id: 'm1');
        await _seedMessage(db, id: 'm2');
        when(
          () => remote.bulkState(
            any(),
            isRead: any(named: 'isRead'),
            isStarred: any(named: 'isStarred'),
            isImportant: any(named: 'isImportant'),
            folder: any(named: 'folder'),
            snoozedUntil: any(named: 'snoozedUntil'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        await repo.bulkUpdateState(['m1', 'm2'], folder: 'archive');

        // Optimistic local write applied despite the remote failure.
        expect((await db.messageDao.getById('m1'))!.folder, 'archive');
        expect((await db.messageDao.getById('m2'))!.folder, 'archive');

        // One outbox state_change per id, carrying the folder change.
        final pending = await db.outboxDao.getPending();
        expect(pending, hasLength(2));
        expect(pending.every((e) => e.operation == 'state_change'), isTrue);
        final ids = pending
            .map(
              (e) => (jsonDecode(e.payloadJson) as Map<String, dynamic>)['id'],
            )
            .toSet();
        expect(ids, {'m1', 'm2'});
        for (final e in pending) {
          final body =
              (jsonDecode(e.payloadJson) as Map<String, dynamic>)['body']
                  as Map<String, dynamic>;
          expect(body['folder'], 'archive');
        }
      },
    );

    test('bulkUpdateState does not enqueue when remote succeeds', () async {
      await _seedMessage(db, id: 'm1');
      when(
        () => remote.bulkState(
          any(),
          isRead: any(named: 'isRead'),
          isStarred: any(named: 'isStarred'),
          isImportant: any(named: 'isImportant'),
          folder: any(named: 'folder'),
          snoozedUntil: any(named: 'snoozedUntil'),
        ),
      ).thenAnswer((_) async {});

      await repo.bulkUpdateState(['m1'], isRead: true);

      expect(await db.outboxDao.getPending(), isEmpty);
    });

    test(
      'restore applies optimistic inbox move and enqueues when offline (A2)',
      () async {
        await _seedMessage(db, id: 'm1', folder: 'trash');
        when(
          () => remote.restore('m1'),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        await repo.restore('m1');

        expect((await db.messageDao.getById('m1'))!.folder, 'inbox');
        final pending = await db.outboxDao.getPending();
        expect(pending, hasLength(1));
        expect(pending.single.operation, 'state_change');
        final payload =
            jsonDecode(pending.single.payloadJson) as Map<String, dynamic>;
        expect(payload['id'], 'm1');
        expect((payload['body'] as Map<String, dynamic>)['folder'], 'inbox');
      },
    );
  });

  group('SyncEngine flush', () {
    test(
      'flushOutbox dispatches queued state_change as a PATCH and clears it',
      () async {
        final db = _memoryDb();
        addTearDown(db.close);
        final dio = _MockDio();
        when(() => dio.patch(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
          ),
        );

        await db.outboxDao.enqueue(
          operation: 'state_change',
          payloadJson: jsonEncode({
            'id': 'm1',
            'body': {'folder': 'inbox'},
          }),
        );

        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            dioClientProvider.overrideWithValue(dio),
            isOnlineProvider.overrideWith((ref) => Stream.value(true)),
          ],
        );
        addTearDown(container.dispose);

        await container.read(syncEngineProvider).flushOutbox();

        verify(
          () => dio.patch('mail/messages/m1/state/', data: any(named: 'data')),
        ).called(1);
        expect(await db.outboxDao.getPending(), isEmpty);
      },
    );
  });

  group('Draft backend sync', () {
    Future<void> seedMailbox(AppDatabase db) => db.mailboxDao.upsertAll([
      MailboxesCompanion.insert(
        id: 'mb1',
        domainId: 'domain1',
        localPart: 'support',
        emailAddress: 'support@example.com',
        updatedAt: DateTime.now().toUtc(),
      ),
    ]);

    const draftReq = SendMessageRequest(
      mailboxId: 'mb1',
      to: [EmailAddress(email: 'customer@example.com')],
      subject: 'Attached draft',
      bodyText: 'Please review.',
    );
    const draftAttachments = [
      ComposeAttachmentRequest(
        filename: 'invoice.pdf',
        contentType: 'application/pdf',
        content: 'SGVkd2ln',
        sizeBytes: 6,
      ),
    ];

    test(
      'saveDraft enqueues a save_draft op carrying body + attachments',
      () async {
        final db = _memoryDb();
        addTearDown(db.close);
        await seedMailbox(db);
        final container = ProviderContainer(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
        );
        addTearDown(container.dispose);

        await container
            .read(composeControllerProvider.notifier)
            .saveDraft(draftReq, attachments: draftAttachments);

        final pending = await db.outboxDao.getPending();
        expect(pending, hasLength(1));
        expect(pending.single.operation, 'save_draft');
        final payload =
            jsonDecode(pending.single.payloadJson) as Map<String, dynamic>;
        expect(payload.containsKey('serverDraftId'), isFalse);
        final body = payload['body'] as Map<String, dynamic>;
        expect(body['mailbox'], 'mb1');
        expect(body['subject'], 'Attached draft');
        final attachments = body['attachments'] as List;
        expect(attachments, hasLength(1));
        expect(attachments.single, containsPair('content', 'SGVkd2ln'));
      },
    );

    test('re-saving the same draft coalesces into one outbox op', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      await seedMailbox(db);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);

      final controller = container.read(composeControllerProvider.notifier);
      final saved = await controller.saveDraft(draftReq);
      await controller.saveDraft(
        const SendMessageRequest(
          mailboxId: 'mb1',
          to: [EmailAddress(email: 'customer@example.com')],
          subject: 'Edited subject',
          bodyText: 'Please review.',
        ),
        draftId: saved.id,
      );

      final pending = await db.outboxDao.getPending();
      expect(pending, hasLength(1));
      final body =
          (jsonDecode(pending.single.payloadJson)
                  as Map<String, dynamic>)['body']
              as Map<String, dynamic>;
      expect(body['subject'], 'Edited subject');
    });

    test('flushOutbox POSTs a new draft and records the server id', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final dio = _MockDio();
      when(
        () => dio.post('mail/messages/draft/', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 201,
          data: {'id': 'srv-draft-1'},
        ),
      );

      await db.outboxDao.enqueue(
        operation: 'save_draft',
        payloadJson: jsonEncode({
          'localId': 'draft-local-1',
          'body': {'mailbox': 'mb1', 'subject': 'Hi'},
        }),
      );
      await db.messageDao.upsertAll([
        MessagesCompanion.insert(
          id: 'draft-local-1',
          mailboxId: 'mb1',
          direction: 'outbound',
          status: 'draft',
          fromAddress: 'support@example.com',
          subject: 'Hi',
          folder: const Value('drafts'),
          metadataJson: const Value('{}'),
          createdAt: DateTime.now().toUtc(),
        ),
      ]);

      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          dioClientProvider.overrideWithValue(dio),
          isOnlineProvider.overrideWith((ref) => Stream.value(true)),
        ],
      );
      addTearDown(container.dispose);

      await container.read(syncEngineProvider).flushOutbox();

      verify(
        () => dio.post('mail/messages/draft/', data: any(named: 'data')),
      ).called(1);
      expect(await db.outboxDao.getPending(), isEmpty);
      // Server id is stored so subsequent saves PATCH the same remote draft.
      final row = await db.messageDao.getById('draft-local-1');
      final metadata = jsonDecode(row!.metadataJson) as Map<String, dynamic>;
      expect(metadata['server_draft_id'], 'srv-draft-1');
    });

    test(
      'flushOutbox PATCHes an existing draft when server id is known',
      () async {
        final db = _memoryDb();
        addTearDown(db.close);
        final dio = _MockDio();
        when(() => dio.patch(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {'id': 'srv-draft-1'},
          ),
        );

        await db.outboxDao.enqueue(
          operation: 'save_draft',
          payloadJson: jsonEncode({
            'localId': 'draft-local-1',
            'serverDraftId': 'srv-draft-1',
            'body': {'mailbox': 'mb1', 'subject': 'Edited'},
          }),
        );

        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            dioClientProvider.overrideWithValue(dio),
            isOnlineProvider.overrideWith((ref) => Stream.value(true)),
          ],
        );
        addTearDown(container.dispose);

        await container.read(syncEngineProvider).flushOutbox();

        verify(
          () => dio.patch(
            'mail/messages/srv-draft-1/draft/',
            data: any(named: 'data'),
          ),
        ).called(1);
        expect(await db.outboxDao.getPending(), isEmpty);
      },
    );
  });

  group('Cross-device drafts', () {
    Future<void> seedMailbox(AppDatabase db) => db.mailboxDao.upsertAll([
      MailboxesCompanion.insert(
        id: 'mb1',
        domainId: 'domain1',
        localPart: 'support',
        emailAddress: 'support@example.com',
        updatedAt: DateTime.now().toUtc(),
      ),
    ]);

    test(
      'cacheRemoteDraft stores a local draft with reference attachments',
      () async {
        final db = _memoryDb();
        addTearDown(db.close);
        await seedMailbox(db);
        final remote = _MockRemote();
        when(() => remote.getByThread('thread-1')).thenAnswer(
          (_) async => const [
            MailMessage(
              id: 'srv-msg-1',
              mailboxId: 'mb1',
              direction: 'outbound',
              status: 'draft',
              folder: 'drafts',
              fromAddress: 'support@example.com',
              subject: 'Hi from device A',
              bodyText: 'hello',
              bodyHtml: '<p>hello</p>',
              toAddresses: [EmailAddress(email: 'c@example.com')],
              hasAttachments: true,
              attachments: [
                Attachment(
                  id: 'att-1',
                  filename: 'a.pdf',
                  contentType: 'application/pdf',
                  sizeBytes: 10,
                ),
              ],
            ),
          ],
        );
        final container = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            messageRepositoryProvider.overrideWithValue(
              MessageRepository(remote: remote, db: db),
            ),
          ],
        );
        addTearDown(container.dispose);

        final ok = await container
            .read(composeControllerProvider.notifier)
            .cacheRemoteDraft('thread-1');

        expect(ok, isTrue);
        // Cached under the server thread id so the drafts-list nav resolves it.
        final row = await db.messageDao.getById('thread-1');
        expect(row != null, isTrue);
        expect(row!.status, 'draft');
        final metadata = jsonDecode(row.metadataJson) as Map<String, dynamic>;
        expect(metadata['server_draft_id'], 'srv-msg-1');
        expect(metadata['server_draft_thread_id'], 'thread-1');
        final composeAttachments = metadata['compose_attachments'] as List;
        // Reference attachment: id present, no downloadable bytes.
        expect(composeAttachments.single, containsPair('id', 'att-1'));
        expect(composeAttachments.single, containsPair('content', ''));
      },
    );

    test('sendDraft enqueues send_draft and clears the local draft', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      await seedMailbox(db);
      await db.messageDao.upsertAll([
        MessagesCompanion.insert(
          id: 'thread-1',
          mailboxId: 'mb1',
          direction: 'outbound',
          status: 'draft',
          fromAddress: 'support@example.com',
          subject: 'Hi',
          folder: const Value('drafts'),
          metadataJson: Value(
            jsonEncode({
              'server_draft_id': 'srv-msg-1',
              'server_draft_thread_id': 'thread-1',
            }),
          ),
          createdAt: DateTime.now().toUtc(),
        ),
      ]);
      await db.threadDao.upsertAll([
        ThreadsCompanion.insert(
          id: 'thread-1',
          mailboxId: 'mb1',
          subject: 'Hi',
          participantsJson: const Value('[]'),
          folder: const Value('drafts'),
          lastMessageAt: DateTime.now().toUtc(),
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);

      await container
          .read(composeControllerProvider.notifier)
          .sendDraft(
            localDraftId: 'thread-1',
            req: const SendMessageRequest(
              mailboxId: 'mb1',
              to: [EmailAddress(email: 'c@example.com')],
              subject: 'Hi',
              bodyText: 'hello',
            ),
            attachments: const [
              ComposeAttachmentRequest(
                filename: 'a.pdf',
                contentType: 'application/pdf',
                content: '',
                sizeBytes: 10,
                serverId: 'att-1',
              ),
            ],
          );

      final ops = (await db.outboxDao.getPending()).map((e) => e.operation);
      expect(ops, containsAll(['save_draft', 'send_draft']));
      // Optimistically removed from Drafts.
      expect((await db.messageDao.getById('thread-1')) == null, isTrue);
    });

    test('flushOutbox promotes a draft via the send-draft endpoint', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final dio = _MockDio();
      when(() => dio.post(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 202,
          data: {
            'id': 'srv-msg-1',
            'mailbox': 'mb1',
            'direction': 'outbound',
            'status': 'sent',
            'folder': 'sent',
            'from_address': 'support@example.com',
            'subject': 'Hi',
          },
        ),
      );
      await db.outboxDao.enqueue(
        operation: 'send_draft',
        payloadJson: jsonEncode({'serverDraftId': 'srv-msg-1'}),
      );
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          dioClientProvider.overrideWithValue(dio),
          isOnlineProvider.overrideWith((ref) => Stream.value(true)),
        ],
      );
      addTearDown(container.dispose);

      await container.read(syncEngineProvider).flushOutbox();

      verify(() => dio.post('mail/messages/srv-msg-1/send-draft/')).called(1);
      expect(await db.outboxDao.getPending(), isEmpty);
      final row = await db.messageDao.getById('srv-msg-1');
      expect(row != null, isTrue);
      expect(row!.folder, 'sent');
    });

    test(
      'drafts refresh dedupes a local draft against its server thread',
      () async {
        final db = _memoryDb();
        addTearDown(db.close);
        await seedMailbox(db);
        // A locally-authored draft already synced to server thread srv-thread-1.
        await db.messageDao.upsertAll([
          MessagesCompanion.insert(
            id: 'draft-local-1',
            mailboxId: 'mb1',
            direction: 'outbound',
            status: 'draft',
            fromAddress: 'support@example.com',
            subject: 'Local',
            folder: const Value('drafts'),
            metadataJson: Value(
              jsonEncode({'server_draft_thread_id': 'srv-thread-1'}),
            ),
            createdAt: DateTime.now().toUtc(),
          ),
        ]);
        await db.threadDao.upsertAll([
          ThreadsCompanion.insert(
            id: 'draft-local-1',
            mailboxId: 'mb1',
            subject: 'Local',
            participantsJson: const Value('[]'),
            folder: const Value('drafts'),
            lastMessageAt: DateTime.now().toUtc(),
            updatedAt: DateTime.now().toUtc(),
          ),
        ]);
        final remote = _MockThreadRemote();
        when(
          () => remote.getThreads(
            mailboxId: any(named: 'mailboxId'),
            folder: any(named: 'folder'),
            search: any(named: 'search'),
            page: any(named: 'page'),
            pageSize: any(named: 'pageSize'),
          ),
        ).thenAnswer(
          (_) async => const PaginatedResponse<MailThread>(
            count: 2,
            results: [
              MailThread(
                id: 'srv-thread-1',
                mailboxId: 'mb1',
                subject: 'Local',
              ),
              MailThread(
                id: 'srv-thread-2',
                mailboxId: 'mb1',
                subject: 'Other',
              ),
            ],
          ),
        );
        final repo = ThreadRepository(remote: remote, db: db);

        final sub = repo
            .watchThreads(mailboxId: 'mb1', folder: 'drafts')
            .listen((_) {});
        // Let the background refresh write reconciled rows, then stop the stream
        // (cancelling its periodic timer).
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await sub.cancel();

        final draftThreads =
            await (db.select(db.threads)..where(
                  (t) => t.mailboxId.equals('mb1') & t.folder.equals('drafts'),
                ))
                .get();
        final ids = draftThreads.map((t) => t.id).toSet();
        // Local draft kept, other device's draft shown, the duplicate hidden.
        expect(ids, containsAll(['draft-local-1', 'srv-thread-2']));
        expect(ids, isNot(contains('srv-thread-1')));
      },
    );
  });
}
