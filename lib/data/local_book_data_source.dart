import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/model/book.dart';
import 'package:kleine_aufgabe/objectbox.g.dart';
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
  void removeBook(String remoteId) {
    final book =
        _box.query(Book_.remoteId.equals(remoteId)).build().findFirst();

    if (book != null) {
      _box.remove(book.localId);
    }
  }

  @override
  Stream<List<Book>> watchBooks() {
    return _box
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }
}
