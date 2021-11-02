import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/cubit/favorite_manager_cubit.dart';
import 'package:kleine_aufgabe/model/book.dart';
import 'package:kleine_aufgabe/presentation/home_page.dart';

class DetailsPage extends StatelessWidget {
  final Book book;
  final BuildContext context;

  const DetailsPage(this.book, {Key? key, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteManagerCubit, FavoriteManagerState>(
      bloc: BlocProvider.of<FavoriteManagerCubit>(this.context),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
            actions: [AddFavoriteButton(book: book, context: this.context)],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: BookImage(
                        book: book,
                        sizeRatio: 0.3,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              book.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              book.authors.join(', '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(book.description),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
