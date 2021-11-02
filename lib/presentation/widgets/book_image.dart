import 'package:flutter/material.dart';
import 'package:kleine_aufgabe/model/book.dart';

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
