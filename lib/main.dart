import 'package:daily_dogs/di.dart';
import 'package:daily_dogs/dogs_display/dogs_display_widget.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: DogsDisplayWidget(),
      ),
    );
  }
}
