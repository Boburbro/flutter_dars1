import 'package:flutter/material.dart';
import 'package:modul11_2_1/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AsSoft LLC",
      home: HomeScreen(),
    );
  }
}