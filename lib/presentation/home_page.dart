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
          title: const Text("Book"),
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<BookSearcherCubit>().queryStarted(),
                icon: const Icon(Icons.search))
          ],
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                ListTile(
                  title: TextField(
                    onChanged: (value) =>
                        context.read<BookSearcherCubit>().keywordChanged(value),
                    decoration: const InputDecoration(
                      hintText: 'type in search keyword...',
                      border: InputBorder.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () =>
                        context.read<BookSearcherCubit>().queryStarted(),
                    icon: const Icon(Icons.search),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BookSearcherCubit, BookSearcherState>(
                    builder: (context, state) {
                      return state.map(
                        initial: (_) => Container(),
                        loadInProgress: (_) =>
                            const Center(child: CircularProgressIndicator()),
                        loadSuccess: (state) =>
                            QueryBookList(books: state.books),
                        loadFailure: (_) => Container(),
                      );
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<FavoriteManagerCubit, FavoriteManagerState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return FavoriteBookList(books: state.favoriteBooks);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QueryBookList extends StatelessWidget {
  final List<Book> books;

  const QueryBookList({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = context
        .select((FavoriteManagerCubit cubit) => cubit.state.favoriteBooks);

    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];

          final isFavorite =
              favorites.map((book) => book.remoteId).contains(book.remoteId);
          return ListTile(
            trailing: IconButton(
                onPressed: () => isFavorite
                    ? context.read<FavoriteManagerCubit>().removeBook(book)
                    : context.read<FavoriteManagerCubit>().addBook(book),
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey,
                )),
            title: Text(book.title),
            subtitle: Text(book.authors.join(", ")),
          );
        });
  }
}

class FavoriteBookList extends StatelessWidget {
  final List<Book> books;

  const FavoriteBookList({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => ListTile(
          trailing: IconButton(
              onPressed: () =>
                  context.read<FavoriteManagerCubit>().removeBook(books[index]),
              icon: const Icon(Icons.delete)),
          title: Text(books[index].title),
          subtitle: Text(books[index].authors.join(", ")),
        ),
      );
}
