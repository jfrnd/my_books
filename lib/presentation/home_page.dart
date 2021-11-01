import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/cubit/book_searcher_cubit.dart';
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
            const Icon(Icons.favorite),
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
  Widget build(BuildContext context) => ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => ListTile(
          trailing:
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          title: Text(books[index].title),
          subtitle: Text(books[index].authors.join(", ")),
        ),
      );
}
