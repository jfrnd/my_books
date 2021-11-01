import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kleine_aufgabe/data/i_remote_book_data_source.dart';
import 'package:kleine_aufgabe/model/book.dart';

part 'book_searcher_state.dart';
part 'book_searcher_cubit.freezed.dart';

@injectable
class BookSearcherCubit extends Cubit<BookSearcherState> {
  String keyword = "";

  final IRemoteBookDataSource remoteDataSource;

  BookSearcherCubit(this.remoteDataSource)
      : super(const BookSearcherState.initial());

  void queryStarted() {
    emit(const BookSearcherState.loadInProgress());

    remoteDataSource.getBooks(keyword).then(
      (books) {
        if (books.isNotEmpty) {
          emit(BookSearcherState.loadSuccess(books));
        } else {
          emit(const BookSearcherState.loadFailure());
        }
      },
    );
  }

  void keywordChanged(String newKeyword) {
    keyword = newKeyword;
  }
}
