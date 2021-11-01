import 'package:kleine_aufgabe/model/book.dart';

abstract class IRemoteBookDataSource {
  Future<List<Book>> getBooks(String keyword);
}
