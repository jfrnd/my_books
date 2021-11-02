import 'package:flutter/material.dart';
import 'package:kleine_aufgabe/cubit/book_searcher_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kleine_aufgabe/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
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
            animationDuration: const Duration(seconds: 0),
            hideOnEmpty: true,
            hideOnLoading: true,
            getImmediateSuggestions: false,
            itemBuilder: (context, suggestion) {
              if (suggestion.contains(controller.text)) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(suggestion),
                );
              } else {
                return const SizedBox();
              }
            },
            onSuggestionSelected: (suggestion) {
              context.read<BookSearcherCubit>().newQueryStarted(suggestion);
              FocusScope.of(context).unfocus();
            },
            suggestionsCallback: (pattern) {
              return getIt<SharedPreferences>().getStringList(BookSearcherCubit.searchHistory) ?? [];
            },
          ),
        ],
      ),
    );
  }
}
