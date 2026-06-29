// ignore_for_file: use_null_aware_elements
import 'package:dio/dio.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';
import 'package:hedwig_client/shared/models/thread.dart';

class ThreadCounts {
  const ThreadCounts({required this.folders, required this.labels});

  final Map<String, int> folders;
  final List<LabelUnreadCount> labels;
}

class LabelUnreadCount {
  const LabelUnreadCount({
    required this.id,
    required this.name,
    required this.unread,
    this.color,
  });

  final String id;
  final String name;
  final int unread;
  final String? color;

  factory LabelUnreadCount.fromJson(Map<String, dynamic> json) =>
      LabelUnreadCount(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        color: json['color'] as String?,
        unread: json['unread'] as int? ?? 0,
      );
}

class ThreadRemoteDatasource {
  const ThreadRemoteDatasource(this._dio);

  final Dio _dio;

  Future<PaginatedResponse<MailThread>> getThreads({
    required String mailboxId,
    String? folder,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    final labelSearch = folder != null && folder.startsWith('label:')
        ? folder.substring(6)
        : null;
    final effectiveFolder = labelSearch == null ? folder : null;
    final effectiveSearch = [
      if (labelSearch != null) 'label:"$labelSearch"',
      if (search != null && search.isNotEmpty) search,
    ].join(' ').trim();
    final res = await _dio.get(
      'mail/threads/',
      queryParameters: {
        'mailbox': mailboxId,
        if (effectiveFolder != null) 'folder': effectiveFolder,
        if (effectiveSearch.isNotEmpty) 'search': effectiveSearch,
        // In a folder view, sort by that folder's latest message; otherwise by
        // the thread's global latest.
        'ordering': effectiveFolder != null
            ? '-folder_last_message_at'
            : '-last_message_at',
        'page': page,
        'page_size': pageSize,
      },
    );
    return PaginatedResponse.fromJson(
      res.data as Map<String, dynamic>,
      (j) => MailThread.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<ThreadCounts> getCounts({required String mailboxId}) async {
    final res = await _dio.get(
      'mail/threads/counts/',
      queryParameters: {'mailbox': mailboxId},
    );
    final data = res.data as Map<String, dynamic>;
    final folders = (data['folders'] as Map<String, dynamic>? ?? {}).map(
      (key, value) => MapEntry(key, value as int? ?? 0),
    );
    final labels = (data['labels'] as List? ?? [])
        .map((row) => LabelUnreadCount.fromJson(row as Map<String, dynamic>))
        .toList();
    return ThreadCounts(folders: folders, labels: labels);
  }
}
