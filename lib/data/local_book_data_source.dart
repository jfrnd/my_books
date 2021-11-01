import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/model/book.dart';
import 'package:objectbox/objectbox.dart';

import 'i_local_book_data_source.dart';

@LazySingleton(as: ILocalBookDataSource)
class LocalBookDataSource implements ILocalBookDataSource {
  final Store _store;
  final Box<Book> _box;

  LocalBookDataSource(this._store) : _box = _store.box();

  @override
  void addBook(Book book) => _box.put(book);

  @override
  void eraseBooks() => _box.removeAll();

  @override
  void removeBook(int id) => _box.remove(id);

  @override
  Stream<List<Book>> watchBooks() {
    return _box
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }
}
