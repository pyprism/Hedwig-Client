import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/labels/data/datasources/label_remote_datasource.dart';

class _RecordedRequest {
  const _RecordedRequest(this.method, this.path, this.data, this.query);

  final String method;
  final String path;
  final Object? data;
  final Map<String, dynamic> query;
}

class _RecordingAdapter implements HttpClientAdapter {
  final requests = <_RecordedRequest>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(
      _RecordedRequest(
        options.method,
        options.path,
        options.data,
        options.queryParameters,
      ),
    );

    if (options.method == 'GET' && options.path == 'mail/message-labels/') {
      return ResponseBody.fromString(
        jsonEncode({
          'count': 1,
          'next': null,
          'previous': null,
          'results': [
            {'id': 'ml1', 'message': 'msg1', 'label': 'lbl1'},
          ],
        }),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }

    return ResponseBody.fromString(
      '{}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

void main() {
  group('LabelRemoteDatasource message-label contract', () {
    test('applyLabel creates through /mail/message-labels/', () async {
      final adapter = _RecordingAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.test/'))
        ..httpClientAdapter = adapter;
      final datasource = LabelRemoteDatasource(dio);

      await datasource.applyLabel(messageId: 'msg1', labelId: 'lbl1');

      expect(adapter.requests, hasLength(1));
      expect(adapter.requests.single.method, 'POST');
      expect(adapter.requests.single.path, 'mail/message-labels/');
      expect(adapter.requests.single.data, {
        'message': 'msg1',
        'label': 'lbl1',
      });
    });

    test('removeLabel looks up the join row before deleting it', () async {
      final adapter = _RecordingAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.test/'))
        ..httpClientAdapter = adapter;
      final datasource = LabelRemoteDatasource(dio);

      await datasource.removeLabel(messageId: 'msg1', labelId: 'lbl1');

      expect(adapter.requests, hasLength(2));
      expect(adapter.requests.first.method, 'GET');
      expect(adapter.requests.first.path, 'mail/message-labels/');
      expect(adapter.requests.first.query, {
        'message': 'msg1',
        'label': 'lbl1',
        'page_size': 1,
      });
      expect(adapter.requests.last.method, 'DELETE');
      expect(adapter.requests.last.path, 'mail/message-labels/ml1/');
    });
  });
}
