import 'package:dio/dio.dart';
import 'package:hedwig_client/shared/models/mailbox.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';

class MailboxRemoteDatasource {
  const MailboxRemoteDatasource(this._dio);

  final Dio _dio;

  Future<List<Mailbox>> getMailboxes() async {
    final res = await _dio.get('mail/mailboxes/');
    final page = PaginatedResponse.fromJson(
      res.data as Map<String, dynamic>,
      (j) => Mailbox.fromJson(j as Map<String, dynamic>),
    );
    return page.results;
  }
}
