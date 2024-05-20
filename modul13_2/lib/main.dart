import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/place_provider.dart';
import 'screens/add_place_screen.dart';
import 'screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              iconColor: Colors.indigo,
              textStyle: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.indigo,
            centerTitle: true,
          ),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo,
        ),
        title: "As Soft LLC",
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
