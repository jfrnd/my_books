part of 'book_searcher_cubit.dart';

@freezed
class BookSearcherState with _$BookSearcherState {
  const factory BookSearcherState.initial() = _Initial;
  const factory BookSearcherState.loadInProgress() = _LoadInProgress;
  const factory BookSearcherState.loadSuccess(List<Book> books) = _LoadSuccess;
  const factory BookSearcherState.loadFailure() = _LoadFailure;
}
