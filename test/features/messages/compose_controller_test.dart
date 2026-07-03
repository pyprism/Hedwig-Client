import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/db/app_database.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/compose_controller.dart';
import 'package:hedwig_client/shared/models/message.dart';

void main() {
  group('ComposeAttachmentRequest', () {
    test('serializes to the backend send attachment shape', () {
      const attachment = ComposeAttachmentRequest(
        filename: 'invoice.pdf',
        contentType: 'application/pdf',
        content: 'SGVkd2ln',
        sizeBytes: 6,
      );

      expect(attachment.toPayload(), {
        'filename': 'invoice.pdf',
        'content_type': 'application/pdf',
        'content': 'SGVkd2ln',
      });
    });

    test('includes content_id for inline image attachments', () {
      const attachment = ComposeAttachmentRequest(
        filename: 'logo.png',
        contentType: 'image/png',
        content: 'SGVkd2ln',
        sizeBytes: 6,
        contentId: 'logo@hedwig',
      );

      expect(attachment.toPayload(), {
        'filename': 'logo.png',
        'content_type': 'image/png',
        'content': 'SGVkd2ln',
        'content_id': 'logo@hedwig',
      });
    });

    test('round-trips through the draft attachment shape', () {
      const attachment = ComposeAttachmentRequest(
        filename: 'logo.png',
        contentType: 'image/png',
        content: 'SGVkd2ln',
        sizeBytes: 6,
        contentId: 'logo@hedwig',
      );

      final restored = ComposeAttachmentRequest.fromDraftJson(
        attachment.toDraftJson(),
      );

      expect(restored.filename, attachment.filename);
      expect(restored.contentType, attachment.contentType);
      expect(restored.content, attachment.content);
      expect(restored.sizeBytes, attachment.sizeBytes);
      expect(restored.contentId, attachment.contentId);
    });
  });

  group('ComposeController draft persistence', () {
    test('keeps sendable attachment content in draft metadata', () async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      await db.mailboxDao.upsertAll([
        MailboxesCompanion.insert(
          id: 'mb1',
          domainId: 'domain1',
          localPart: 'support',
          emailAddress: 'support@example.com',
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);
      final container = ProviderContainer(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      addTearDown(container.dispose);

      final saved = await container
          .read(composeControllerProvider.notifier)
          .saveDraft(
            const SendMessageRequest(
              mailboxId: 'mb1',
              to: [EmailAddress(email: 'customer@example.com')],
              subject: 'Attached draft',
              bodyText: 'Please review.',
            ),
            attachments: const [
              ComposeAttachmentRequest(
                filename: 'invoice.pdf',
                contentType: 'application/pdf',
                content: 'SGVkd2ln',
                sizeBytes: 6,
              ),
            ],
          );

      final row = await db.messageDao.getById(saved.id);
      expect(row, isNotNull);
      expect(row!.hasAttachments, isTrue);

      final attachmentRows = jsonDecode(row.attachmentsJson) as List;
      expect(attachmentRows.single, isNot(contains('content')));

      final metadata = jsonDecode(row.metadataJson) as Map<String, dynamic>;
      final composeAttachments =
          metadata['compose_attachments'] as List<dynamic>;
      expect(composeAttachments, hasLength(1));
      expect(
        composeAttachments.single,
        containsPair('filename', 'invoice.pdf'),
      );
      expect(composeAttachments.single, containsPair('content', 'SGVkd2ln'));
      expect(composeAttachments.single, containsPair('size_bytes', 6));
    });
  });

  group('ComposeController send', () {
    test('links a new optimistic sent message to its local thread', () async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      await db.mailboxDao.upsertAll([
        MailboxesCompanion.insert(
          id: 'mb1',
          domainId: 'domain1',
          localPart: 'support',
          emailAddress: 'support@example.com',
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          dioClientProvider.overrideWithValue(Dio()),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(composeControllerProvider.notifier);
      await controller.send(
        const SendMessageRequest(
          mailboxId: 'mb1',
          to: [EmailAddress(email: 'customer@example.com')],
          subject: 'Queued send',
          bodyText: 'Hello.',
        ),
      );

      expect(container.read(composeControllerProvider).hasError, isFalse);
      final localId = controller.lastLocalMessageId;
      expect(localId, isNotNull);

      final thread = await db.threadDao.getByIdFolder(localId!, 'sent');
      expect(thread, isNotNull);

      final messages = await db.messageDao.getByThread(localId);
      expect(messages, hasLength(1));
      expect(messages.single.id, localId);
      expect(messages.single.folder, 'sent');
    });

    test('flushes scheduled sends after undo window', () async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(db.close);
      await db.mailboxDao.upsertAll([
        MailboxesCompanion.insert(
          id: 'mb1',
          domainId: 'domain1',
          localPart: 'support',
          emailAddress: 'support@example.com',
          updatedAt: DateTime.now().toUtc(),
        ),
      ]);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          dioClientProvider.overrideWithValue(Dio()),
        ],
      );
      addTearDown(container.dispose);

      final scheduledAt = DateTime.now().toUtc().add(const Duration(hours: 1));
      final beforeSend = DateTime.now().toUtc();
      await container
          .read(composeControllerProvider.notifier)
          .send(
            SendMessageRequest(
              mailboxId: 'mb1',
              to: const [EmailAddress(email: 'customer@example.com')],
              subject: 'Scheduled send',
              bodyText: 'Hello later.',
              scheduledAt: scheduledAt,
            ),
          );

      final pending = await db.outboxDao.getPending();
      expect(pending, hasLength(1));
      final payload =
          jsonDecode(pending.single.payloadJson) as Map<String, dynamic>;
      final notBefore = DateTime.parse(payload['notBefore'] as String);

      expect(notBefore.isAfter(beforeSend), isTrue);
      expect(notBefore.isBefore(scheduledAt), isTrue);
      expect(
        scheduledAt.difference(notBefore) > const Duration(minutes: 30),
        isTrue,
      );
    });
  });
}
