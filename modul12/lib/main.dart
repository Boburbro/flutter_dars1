import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/home_binding.dart';
import 'views/screens/details_screen.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBindning(),
      initialRoute: '/home',
      // home: HomeScreen(),
      getPages: [
        GetPage(
            name: '/home', page: () => HomeScreen(), binding: HomeBindning()),
        GetPage(name: '/details', page: () => DetailsScreen()),
      ],
    );
  }
}
