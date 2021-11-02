import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/book_searcher_cubit.dart';
import 'package:kleine_aufgabe/cubit/favorite_manager_cubit.dart';
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
              text: "Google Books",
              icon: Icon(Icons.language),
            ),
            Tab(
              text: "My Favorites",
              icon: Icon(Icons.favorite),
            ),
          ]),
          title: const Text("Google Books"),
        ),
        body: TabBarView(
          children: [
            Column(
              children: const [
                SearchBar(),
                Expanded(child: QueryBookList()),
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
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.grey[200],
        title: TextField(
          onChanged: (value) =>
              context.read<BookSearcherCubit>().keywordChanged(value),
          decoration: const InputDecoration(
            hintText: 'type in search keyword...',
            border: InputBorder.none,
          ),
        ),
        trailing: IconButton(
          onPressed: () => context.read<BookSearcherCubit>().queryStarted(),
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class QueryBookList extends StatelessWidget {
  const QueryBookList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookSearcherCubit, BookSearcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (_) => const Center(
            child: Text('search failed :-('),
          ),
          loadSuccess: (state) => ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];

                return ListTile(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => DetailsPage(book, context: context),
                  ),
                  leading: BookImage(book: book, sizeRatio: 0.1),
                  trailing: AddFavoriteButton(book: book, context: context),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(", ")),
                );
              }),
        );
      },
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
          } else {
            return ListView.builder(
              itemCount: state.favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = state.favoriteBooks[index];
                return ListTile(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => DetailsPage(book, context: context),
                  ),
                  leading: BookImage(book: book, sizeRatio: 0.1),
                  trailing: IconButton(
                      onPressed: () =>
                          context.read<FavoriteManagerCubit>().removeBook(book),
                      icon: const Icon(Icons.delete)),
                  title: Text(book.title),
                  subtitle: Text(
                    book.authors.join(", "),
                  ),
                );
              },
            );
          }
        },
      );
}

class AddFavoriteButton extends StatelessWidget {
  final Book book;
  final BuildContext context;

  const AddFavoriteButton({
    Key? key,
    required this.book,
    required this.context,
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
            Icons.favorite,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
