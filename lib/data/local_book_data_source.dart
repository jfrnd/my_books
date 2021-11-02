import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/model/book.dart';
import 'package:kleine_aufgabe/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

abstract class ILocalBookDataSource {
  Stream<List<Book>> watchBooks();
  void addBook(Book note);
  void removeBook(String remoteId);
  void eraseBooks();
}

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
    final query = _box.query(Book_.remoteId.equals(remoteId)).build();
    final book = query.findFirst();
    if (book != null) {
      _box.remove(book.localId);
      query.close();
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
