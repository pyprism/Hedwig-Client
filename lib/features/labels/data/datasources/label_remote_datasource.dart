// ignore_for_file: use_null_aware_elements
import 'package:dio/dio.dart';
import 'package:hedwig_client/shared/models/label.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';

class LabelRemoteDatasource {
  const LabelRemoteDatasource(this._dio);

  final Dio _dio;

  Future<List<Label>> getLabels({required String mailboxId}) async {
    final res = await _dio.get(
      'mail/labels/',
      queryParameters: {'mailbox': mailboxId, 'page_size': 100},
    );
    final page = PaginatedResponse.fromJson(
      res.data as Map<String, dynamic>,
      (j) => Label.fromJson(j as Map<String, dynamic>),
    );
    return page.results;
  }

  Future<Label> createLabel({
    required String mailboxId,
    required String name,
    String? color,
  }) async {
    final res = await _dio.post(
      'mail/labels/',
      data: {
        'mailbox': mailboxId,
        'name': name,
        if (color != null) 'color': color,
      },
    );
    return Label.fromJson(res.data as Map<String, dynamic>);
  }

  Future<Label> updateLabel(String id, {String? name, String? color}) async {
    final res = await _dio.patch(
      'mail/labels/$id/',
      data: {if (name != null) 'name': name, if (color != null) 'color': color},
    );
    return Label.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteLabel(String id) => _dio.delete('mail/labels/$id/');

  Future<void> applyLabel({
    required String messageId,
    required String labelId,
  }) => _dio.post(
    'mail/message-labels/',
    data: {'message': messageId, 'label': labelId},
  );

  Future<void> removeLabel({
    required String messageId,
    required String labelId,
  }) async {
    final res = await _dio.get(
      'mail/message-labels/',
      queryParameters: {'message': messageId, 'label': labelId, 'page_size': 1},
    );
    final results = (res.data['results'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    if (results.isEmpty) return;
    await _dio.delete('mail/message-labels/${results.first['id']}/');
  }

  Future<List<String>> getMessageLabelIds(String messageId) async {
    final res = await _dio.get(
      'mail/message-labels/',
      queryParameters: {'message': messageId, 'page_size': 100},
    );
    final results = (res.data['results'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    return results.map((row) => row['label'] as String).toList();
  }
}
