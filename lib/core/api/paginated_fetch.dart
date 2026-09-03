import 'package:dio/dio.dart';

/// Fetches every page of a DRF-paginated list endpoint (`{count, next,
/// previous, results}`), following `next` until it's null.
///
/// Admin screens load a bounded, org-sized list (mailboxes, users, domains,
/// ...) into a single in-memory list rather than an infinite-scroll view, so
/// a single `page_size: 100` request silently truncated any org past 100
/// rows with no "load more" and no error. This is the fix for that: still
/// one round-trip per page, but no row is ever silently dropped.
Future<List<T>> fetchAllPages<T>(
  Dio dio,
  String path,
  T Function(Map<String, dynamic>) fromJson, {
  Map<String, dynamic>? queryParameters,
}) async {
  final items = <T>[];
  String? nextPath = path;
  Map<String, dynamic>? query = queryParameters;
  while (nextPath != null) {
    final res = await dio.get(nextPath, queryParameters: query);
    items.addAll(
      (res.data['results'] as List? ?? []).cast<Map<String, dynamic>>().map(
        fromJson,
      ),
    );
    nextPath = res.data['next'] as String?;
    query = null; // `next` is already a full URL with its own query string.
  }
  return items;
}
