import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:modul11_2_1/logic/cubit/weather/weather_cubit.dart';
import 'package:modul11_2_1/logic/repositories/weather_repostory.dart';
import 'package:modul11_2_1/logic/services/weather_api_services.dart';

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
            create: (ctx) =>
                WeatherCubit(weatherRepository: ctx.read<WeatherRepository>()),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "AsSoft LLC",
          home: HomeScreen(),
        ),
      ),
    );
  }
}
