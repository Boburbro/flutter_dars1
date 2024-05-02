import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

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
  final String city = "Toshkent Shahri";

  @override
  void initState() {
    context.read<WeatherBloc>().add(WeatherLoadingEvent(city: city));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is WeatherLoaded) {
            return Stack(
              children: [
                const BackgroundImage(),
                NowWeather(
                  weather: state.weather,
                ),
                WeeklyWeather(
                  weatherList: state.weatherList,
                ),
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
          } else if (state is CityLoading) {
            return Center(
              child: Container(
                color: const Color(0xFF1C1B33),
                child: const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 100,
                ),
              ),
            );
          } else if (state is CityLoaded) {
            return Center(
              child: Container(
                color: const Color(0xFF1C1B33),
                child: const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 100,
                ),
              ),
            );
          } else if (state is CityError) {
            if (state.message.contains("Not Found")) {
              return Scaffold(
                backgroundColor: Colors.blueGrey[800],
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "The city not found",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: LottieBuilder.asset(
                            'assets/animations/error1.json'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context.read<WeatherBloc>().add(
                              WeatherLoadingEvent(city: "Tashkent"),
                            ),
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: const Text("Try again"),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container(
              color: const Color(0xFF1C1B33),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LottieBuilder.asset('assets/animations/error.json'),
                    ElevatedButton.icon(
                      onPressed: () => context.read<WeatherBloc>().add(
                            WeatherLoadingEvent(city: "Tashkent"),
                          ),
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text("Try again"),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is WeatherError) {
            if (state.message.contains("Not Found")) {
              return Scaffold(
                backgroundColor: Colors.blueGrey[800],
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "The city not found",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: LottieBuilder.asset(
                            'assets/animations/error1.json'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context.read<WeatherBloc>().add(
                              WeatherLoadingEvent(city: "Tashkent"),
                            ),
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: const Text("Try again"),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
              color: const Color(0xFF1C1B33),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LottieBuilder.asset('assets/animations/error.json'),
                    ElevatedButton.icon(
                      onPressed: () => context.read<WeatherBloc>().add(
                            WeatherLoadingEvent(city: "Tashkent"),
                          ),
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text("Try again"),
                    ),
                  ],
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
