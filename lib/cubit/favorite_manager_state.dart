part of 'favorite_manager_cubit.dart';

@freezed
class FavoriteManagerState with _$FavoriteManagerState {
  const factory FavoriteManagerState({
    required bool isLoading,
    required List<Book> favoriteBooks,
  }) = _FavoriteManagerState;

  factory FavoriteManagerState.initial() => const FavoriteManagerState(
        isLoading: true,
        favoriteBooks: [],
      );
}
