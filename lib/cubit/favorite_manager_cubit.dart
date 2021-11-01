import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/data/i_local_book_data_source.dart';
import 'package:kleine_aufgabe/model/book.dart';

part 'favorite_manager_state.dart';
part 'favorite_manager_cubit.freezed.dart';

@injectable
class FavoriteManagerCubit extends Cubit<FavoriteManagerState> {
  final ILocalBookDataSource localBookDataSource;

  FavoriteManagerCubit(this.localBookDataSource)
      : super(FavoriteManagerState.initial());

  StreamSubscription<List<Book>>? streamSubscription;

  @override
  Future<void> close() async {
    await streamSubscription?.cancel();
    return super.close();
  }

  void addBook(Book book) => localBookDataSource.addBook(book);
  void removeBook(Book book) => localBookDataSource.removeBook(book.id);
  void eraseBooks() => localBookDataSource.eraseBooks();

  Future<void> watchFavoritesStarted() async {
    await streamSubscription?.cancel();

    emit(state.copyWith(isLoading: true));

    streamSubscription = localBookDataSource.watchBooks().listen(
      (books) {
        emit(state.copyWith(
          isLoading: false,
          favoriteBooks: books,
        ));
      },
    );
  }
}
