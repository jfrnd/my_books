import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/data/remote_book_data_source.dart';
import 'package:kleine_aufgabe/exceptions.dart';
import 'package:kleine_aufgabe/model/book.dart';

part 'book_searcher_state.dart';
part 'book_searcher_cubit.freezed.dart';

@injectable
class BookSearcherCubit extends Cubit<BookSearcherState> {
  final IRemoteBookDataSource remoteDataSource;

  BookSearcherCubit(this.remoteDataSource) : super(BookSearcherState.initial());

  Future<void> newQueryStarted(String keyword) async {
    emit(state.copyWith(
      isLoading: true,
      loadingFailed: false,
      curQuerryKeyword: keyword,
      books: [],
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
    } on ServerException {
      emit(
        state.copyWith(
          books: [],
          isLoading: false,
          loadingFailed: true,
          nextStartIndex: 0,
        ),
      );
    }
  }

  Future<void> curQueryExtended() async {
    emit(state.copyWith(
      isLoading: true,
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
            isLoading: false,
            nextStartIndex: state.nextStartIndex + 10,
          ),
        );
      }
    } on ServerException {
      emit(
        state.copyWith(
          books: [],
          isLoading: false,
          nextStartIndex: 0,
        ),
      );
    }
  }
}
