import 'package:kleine_aufgabe/model/book.dart';

abstract class ILocalBookDataSource {
  Stream<List<Book>> watchBooks();
  void addBook(Book note);
  void removeBook(int id);
  void eraseBooks();
}
