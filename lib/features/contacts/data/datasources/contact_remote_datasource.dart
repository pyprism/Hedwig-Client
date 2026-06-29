// ignore_for_file: use_null_aware_elements
import 'package:dio/dio.dart';
import 'package:hedwig_client/shared/models/contact.dart';
import 'package:hedwig_client/shared/models/paginated_response.dart';

class ContactRemoteDatasource {
  const ContactRemoteDatasource(this._dio);

  final Dio _dio;

  Future<List<Contact>> getContacts({
    required String mailboxId,
    String? search,
  }) async {
    final res = await _dio.get(
      'mail/contacts/',
      queryParameters: {
        'mailbox': mailboxId,
        if (search != null && search.isNotEmpty) 'search': search,
        'ordering': '-last_contacted_at',
        'page_size': 100,
      },
    );
    final page = PaginatedResponse.fromJson(
      res.data as Map<String, dynamic>,
      (j) => Contact.fromJson(j as Map<String, dynamic>),
    );
    return page.results;
  }

  Future<Contact> createContact({
    required String mailboxId,
    required String email,
    String? name,
    bool isFavorite = false,
  }) async {
    final res = await _dio.post(
      'mail/contacts/',
      data: {
        'mailbox': mailboxId,
        'email': email,
        if (name != null) 'name': name,
        'is_favorite': isFavorite,
      },
    );
    return Contact.fromJson(res.data as Map<String, dynamic>);
  }

  Future<Contact> updateContact(
    String id, {
    String? name,
    bool? isFavorite,
  }) async {
    final res = await _dio.patch(
      'mail/contacts/$id/',
      data: {
        if (name != null) 'name': name,
        if (isFavorite != null) 'is_favorite': isFavorite,
      },
    );
    return Contact.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteContact(String id) => _dio.delete('mail/contacts/$id/');
}
