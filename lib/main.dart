import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AlcatrazApp());
}

class AlcatrazApp extends StatelessWidget {
  const AlcatrazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alcatraz - Escape Room Solver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
