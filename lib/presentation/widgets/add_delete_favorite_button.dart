import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/favorite_manager_cubit.dart';
import 'package:kleine_aufgabe/model/book.dart';

class AddDeleteFavoriteButton extends StatelessWidget {
  final IconData iconData;
  final Book book;
  final BuildContext context;

  const AddDeleteFavoriteButton({
    Key? key,
    required this.book,
    required this.context,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteManagerCubit, FavoriteManagerState>(
      bloc: BlocProvider.of(this.context),
      buildWhen: (p, c) => p.favoriteBooks != c.favoriteBooks,
      builder: (context, state) {
        final isFavorite = state.favoriteBooks
            .map((book) => book.remoteId)
            .contains(book.remoteId);
        return IconButton(
          onPressed: () => isFavorite
              ? this.context.read<FavoriteManagerCubit>().removeBook(book)
              : this.context.read<FavoriteManagerCubit>().addBook(book),
          icon: Icon(
            iconData,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
