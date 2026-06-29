import 'package:dio/dio.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';

class MessageRemoteDatasource {
  const MessageRemoteDatasource(this._dio);

  final Dio _dio;

  Future<List<MailMessage>> getByThread(String threadId) async {
    final res = await _dio.get(
      'mail/messages/',
      queryParameters: {
        'thread': threadId,
        'ordering': 'created_at',
        'page_size': 100,
      },
    );
    final page = PaginatedResponse.fromJson(
      res.data as Map<String, dynamic>,
      (j) => MailMessage.fromJson(j as Map<String, dynamic>),
    );
    return page.results;
  }

  Future<void> cancel(String messageId) async {
    await _dio.post('mail/messages/$messageId/cancel/');
  }

  Future<void> restore(String messageId) async {
    await _dio.post('mail/messages/$messageId/restore/');
  }

  Future<void> permanentDelete(String messageId) async {
    await _dio.delete('mail/messages/$messageId/permanent-delete/');
  }

  Future<MailMessage> getById(String messageId) async {
    final res = await _dio.get('mail/messages/$messageId/');
    return MailMessage.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> bulkState(
    List<String> ids, {
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    String? folder,
    DateTime? snoozedUntil,
  }) async {
    await _dio.post(
      'mail/messages/bulk-state/',
      data: {
        'ids': ids,
        'is_read': ?isRead,
        'is_starred': ?isStarred,
        'is_important': ?isImportant,
        'folder': ?folder,
        if (snoozedUntil != null)
          'snoozed_until': snoozedUntil.toIso8601String(),
      },
    );
  }

  Future<String> getAttachmentDownloadUrl(String attachmentId) async {
    final res = await _dio.get('mail/attachments/$attachmentId/download/');
    return res.data['url'] as String;
  }
}
