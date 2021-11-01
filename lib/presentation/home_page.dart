import 'package:flutter/material.dart';

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
          actions: [],
        ),
        body: TabBarView(
          children: [
            const Icon(Icons.language),
            const Icon(Icons.favorite),
          ],
        ),
      ),
    );
  }
}
