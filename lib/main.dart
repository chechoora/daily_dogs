import 'package:daily_dogs/di.dart';
import 'package:daily_dogs/dogs_display/dogs_display_widget.dart';
import 'package:daily_dogs/favorites_display/favorites_display_widget.dart';
import 'package:flutter/material.dart';

void main() {
  setupDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Daily Dogs'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.favorite)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DogsDisplayWidget(),
              FavoritesDisplayWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
