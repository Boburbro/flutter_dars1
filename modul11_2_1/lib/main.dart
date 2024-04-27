import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:modul11_2_1/logic/cubit/settings/settings_cubit.dart';
import 'package:modul11_2_1/presentation/screens/search_city_screen.dart';
import 'package:modul11_2_1/presentation/screens/settings_screen.dart';

import 'logic/cubit/weather/weather_cubit.dart';
import 'logic/repositories/weather_repostory.dart';
import 'logic/services/weather_api_services.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherAPIService: WeatherAPIService(
          client: Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => WeatherCubit(
              weatherRepository: ctx.read<WeatherRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => SettingsCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            // useMaterial3: false,
          ),
          title: "AsSoft LLC",
          home: const HomeScreen(),
          routes: {
            SearchCity.routeName: (context) => SearchCity(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
