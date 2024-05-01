import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../logic/bloc/weather/weather_bloc.dart';
import '../widgets/background_image.dart';
import '../widgets/now_weather.dart';
import '../widgets/weekly_weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(WeatherLoadingEvent(city: "Ferghana"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoaded) {}
        },
        builder: (context, state) {
          if (state is WeatherLoaded) {
            return Stack(
              children: [
                const BackgroundImage(),
                NowWeather(
                  weather: state.weather,
                ),
                const WeeklyWeather(),
              ],
            );
          } else if (state is WeatherLoading) {
            return Center(
              child: Container(
                color: const Color(0xFF1C1B33),
                child: const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 100,
                ),
              ),
            );
          }

          return const Center();
        },
      ),
    );
  }
}
