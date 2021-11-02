import 'package:flutter/material.dart';
import 'package:kleine_aufgabe/model/book.dart';

import '../details_page.dart';
import 'add_delete_favorite_button.dart';
import 'book_image.dart';

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
