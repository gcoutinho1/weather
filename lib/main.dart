import 'package:flutter/material.dart';
import 'package:weather/screens/loading_screen.dart';

/// Created by Guilherme Coutinho © 2022
/// 4FUN

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
