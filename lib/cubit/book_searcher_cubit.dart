import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/data/remote_book_data_source.dart';
import 'package:kleine_aufgabe/model/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'book_searcher_state.dart';
part 'book_searcher_cubit.freezed.dart';

@injectable
class BookSearcherCubit extends Cubit<BookSearcherState> {
  final IRemoteBookDataSource remoteDataSource;
  final SharedPreferences prefs;

  static const searchHistory = "history";

  BookSearcherCubit(this.remoteDataSource, this.prefs)
      : super(BookSearcherState.initial());

  Future<void> newQueryStarted(String keyword) async {
    updateSearchHistory(keyword);

    emit(state.copyWith(
      isLoading: true,
      loadingFailed: false,
      curQuerryKeyword: keyword,
      books: [],
      nextStartIndex: 0,
    ));

    try {
      final books = await remoteDataSource.getBooks(
        keyword,
        0,
      );
      if (books.isNotEmpty) {
        emit(
          state.copyWith(
            books: books,
            isLoading: false,
            loadingFailed: false,
            nextStartIndex: 10,
          ),
        );
      }
    } on Exception {
      emit(
        state.copyWith(
          isLoading: false,
          loadingFailed: true,
        ),
      );
    }
  }

  Future<void> curQueryExtended() async {
    emit(state.copyWith(
      isLoading: true,
      loadingFailed: false,
    ));

    try {
      final books = await remoteDataSource.getBooks(
        state.curQuerryKeyword,
        state.nextStartIndex,
      );
      if (books.isNotEmpty) {
        emit(
          state.copyWith(
            books: state.books + books,
            loadingFailed: false,
            isLoading: false,
            nextStartIndex: state.nextStartIndex + 10,
          ),
        );
      }
    } on Exception {
      emit(
        state.copyWith(
          isLoading: false,
          loadingFailed: true,
        ),
      );
    }
  }

  void updateSearchHistory(String keyword) {
    final List<String> searchHistory =
        prefs.getStringList(BookSearcherCubit.searchHistory) ?? [];
    if (!searchHistory.contains(keyword) && keyword.isNotEmpty) {
      prefs.setStringList(BookSearcherCubit.searchHistory,
          ([keyword] + searchHistory).take(10).toList());
    }
  }
}
