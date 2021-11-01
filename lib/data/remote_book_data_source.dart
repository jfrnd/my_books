import 'package:http/http.dart';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/model/book.dart';

import 'i_remote_book_data_source.dart';

@LazySingleton(as: IRemoteBookDataSource)
class RemoteBookDataSource implements IRemoteBookDataSource {
  final Client client;

  RemoteBookDataSource(this.client);

  @override
  Future<List<Book>> getBooks(String keyword) {
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$keyword&key=AIzaSyBdg9xKHFCG8pbyrTDE-O2H3fEU6AU9QsE');

    return client.get(url).then(
      (response) {
        final Map<String, dynamic> responseMap = json.decode(response.body);
        final List<dynamic> items = responseMap['items'] ?? [];
        final List<Book> books = items.map((item) {
          return Book.fromJson(item);
        }).toList();
        return books;
      },
    );
  }
}
