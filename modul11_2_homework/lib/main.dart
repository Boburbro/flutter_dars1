import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul11_2_homework/presentation/screens/home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.montserrat().fontFamily),
      title: "Weather",
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
