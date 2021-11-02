import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/book_searcher_cubit.dart';
import 'package:kleine_aufgabe/cubit/favorite_manager_cubit.dart';
import 'package:kleine_aufgabe/di/injection.dart';
import 'package:kleine_aufgabe/di/scroll_controller.dart';
import 'package:kleine_aufgabe/presentation/widgets/book_list_tile.dart';
import 'package:kleine_aufgabe/presentation/widgets/search_bar.dart';


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
