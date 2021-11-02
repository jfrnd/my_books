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
            actions: [
              AddDeleteFavoriteButton(
                book: book,
                context: this.context,
                iconData: Icons.favorite,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: Theme.of(context).textTheme.headline5,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              book.subtitle,
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                book.authors.join(', '),
                                style: Theme.of(context).textTheme.headline6,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                book.description.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          color: Colors.grey[100],
                          child: Text(
                            book.description,
                            style: Theme.of(context).textTheme.headline6!,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ]),
            ),
          ),
        );
      },
    );
  }
}
