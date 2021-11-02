import 'package:flutter/material.dart';
import 'package:kleine_aufgabe/cubit/book_searcher_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
