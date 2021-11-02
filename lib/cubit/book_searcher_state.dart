part of 'book_searcher_cubit.dart';

@freezed
class BookSearcherState with _$BookSearcherState {
  const factory BookSearcherState({
    required bool isLoading,
    required bool loadingFailed,
    required List<Book> books,
    required int nextStartIndex,
    required String curQuerryKeyword,
  }) = _BookSearcherState;

  factory BookSearcherState.initial() => const BookSearcherState(
        isLoading: false,
        loadingFailed: false,
        books: [],
        curQuerryKeyword: "",
        nextStartIndex: 0,
      );
}
