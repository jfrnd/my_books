import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/book_searcher_cubit.dart';
import 'package:kleine_aufgabe/cubit/favorite_manager_cubit.dart';
import 'package:kleine_aufgabe/di/injection.dart';
import 'package:kleine_aufgabe/di/scroll_controller.dart';
import 'package:kleine_aufgabe/model/book.dart';

import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: "Browse",
              icon: Icon(Icons.language),
            ),
            Tab(
              text: "Favorites",
              icon: Icon(Icons.favorite),
            ),
          ]),
          title: const Text("My Books"),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                SearchBar(),
                const Expanded(child: QueryBookList()),
              ],
            ),
            const FavoriteBookList(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'type in search keyword...',
          border: const OutlineInputBorder(),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context
                  .read<BookSearcherCubit>()
                  .newQueryStarted(controller.text);
              FocusScope.of(context).unfocus();
            },
          ),
          suffixIcon: IconButton(
            onPressed: () => controller.clear(),
            icon: const Icon(Icons.clear),
          ),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) =>
            context.read<BookSearcherCubit>().newQueryStarted(value),
      ),
    );
  }
}

class QueryBookList extends StatelessWidget {
  const QueryBookList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController =
        getIt<MyScrollController>().getScrollController();

    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        context.read<BookSearcherCubit>().curQueryExtended();
      }
    });

    return BlocBuilder<BookSearcherCubit, BookSearcherState>(
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
          itemCount: state.books.length + 1,
          itemBuilder: (context, index) {
            if (index < state.books.length) {
              final book = state.books[index];

              return BookListTile(
                book: book,
                actionButtonIconData: Icons.favorite,
              );
            } else {
              return state.isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : state.books.isEmpty && state.loadingFailed
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Center(
                              child: Text('❌ No results. Try again 😊.')),
                        )
                      : const SizedBox(height: 64);
            }
          },
        );
      },
    );
  }
}

class BookListTile extends StatelessWidget {
  const BookListTile({
    Key? key,
    required this.book,
    required this.actionButtonIconData,
  }) : super(key: key);

  final Book book;
  final IconData actionButtonIconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showDialog(
        context: context,
        builder: (_) => DetailsPage(book, context: context),
      ),
      leading: BookImage(book: book, sizeRatio: 0.1),
      trailing: AddDeleteFavoriteButton(
          book: book, context: context, iconData: actionButtonIconData),
      title: Text(book.title, overflow: TextOverflow.ellipsis, maxLines: 2),
      subtitle: Text(book.authors.join(", "),
          overflow: TextOverflow.ellipsis, maxLines: 1),
    );
  }
}

class BookImage extends StatelessWidget {
  const BookImage({
    Key? key,
    required this.book,
    required this.sizeRatio,
  }) : super(key: key);

  final Book book;
  final double sizeRatio;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      book.imageUrl ?? "",
      height: MediaQuery.of(context).size.height * sizeRatio,
      width: MediaQuery.of(context).size.width * sizeRatio,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: const FittedBox(child: Icon(Icons.book_online))),
    );
  }
}

class FavoriteBookList extends StatelessWidget {
  const FavoriteBookList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FavoriteManagerCubit, FavoriteManagerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.favoriteBooks.isEmpty) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Text(
                  'No favorite books added yet. Search for books and add some 📚💓.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = state.favoriteBooks[index];

                return BookListTile(
                  book: book,
                  actionButtonIconData: Icons.delete,
                );
              },
            );
          }
        },
      );
}

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
