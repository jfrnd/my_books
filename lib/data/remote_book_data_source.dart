import 'package:http/http.dart';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/model/book.dart';

import '../apikey.dart';
import '../exceptions.dart';

abstract class IRemoteBookDataSource {
  /// Calls the https://www.googleapis.com/books/v1/volumes?q=$keyword&maxResults=40&key=$apiKey endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Book>> getBooks(String keyword);
  Future<List<Book>> getBooksExtended(String keyword, int startIndex);
}

@LazySingleton(as: IRemoteBookDataSource)
class RemoteBookDataSource implements IRemoteBookDataSource {
  final Client client;

  RemoteBookDataSource(this.client);

  @override
  Future<List<Book>> getBooks(String keyword) async {
    final url = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$keyword&maxResults=40&key=$apiKey',
    );

    return client.get(url).then(
      (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseMap = json.decode(response.body);
          final List<dynamic> items = responseMap['items'] ?? [];
          final List<Book> books = items.map((item) {
            return Book.fromJson(item);
          }).toList();
          return books;
        } else {
          throw ServerException();
        }
      },
    );
  }

  @override
  Future<List<Book>> getBooksExtended(String keyword, int startIndex) {
    final url = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$keyword&maxResults=10&startIndex=$startIndex&key=$apiKey',
    );

    return client.get(url).then(
      (response) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseMap = json.decode(response.body);
          final List<dynamic> items = responseMap['items'] ?? [];
          final List<Book> books = items.map((item) {
            return Book.fromJson(item);
          }).toList();
          return books;
        } else {
          throw ServerException();
        }
      },
    );
  }
}
