import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/book_searcher_cubit.dart';
import 'package:kleine_aufgabe/cubit/favorite_manager_cubit.dart';
import 'package:kleine_aufgabe/model/book.dart';

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
    final favorites = context
        .select((FavoriteManagerCubit cubit) => cubit.state.favoriteBooks);

    return BlocBuilder<BookSearcherCubit, BookSearcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (_) => Container(),
          loadSuccess: (state) => ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];

                final isFavorite = favorites
                    .map((book) => book.remoteId)
                    .contains(book.remoteId);
                return ListTile(
                  trailing: IconButton(
                      onPressed: () => isFavorite
                          ? context
                              .read<FavoriteManagerCubit>()
                              .removeBook(book)
                          : context.read<FavoriteManagerCubit>().addBook(book),
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.red : Colors.grey,
                      )),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(", ")),
                );
              }),
        );
      },
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
