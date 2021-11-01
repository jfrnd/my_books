import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'cubit/book_searcher_cubit.dart';
import 'cubit/favorite_manager_cubit.dart';
import 'di/injection.dart';
import 'presentation/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kleine_aufgabe',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<BookSearcherCubit>(),
          ),
          BlocProvider(
            create: (context) =>
                getIt<FavoriteManagerCubit>()..watchFavoritesStarted(),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
