import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modul11_2_1/helper/extensions/string_extension.dart';
import '../../logic/cubit/weather/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<WeatherCubit>().getWeather("ferghana");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (ctx, state) {
          if (state is WeatherError) {
            showDialog(
              context: ctx,
              builder: (ctx) => AlertDialog(
                title: const Text("Error:"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          }
        },
        builder: (ctx, state) {
          if (state is WeatherInitial) {
            return const Center(
              child: Text("Select a city"),
            );
          } else if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            final mainWeather = weather.main.toLowerCase();

            String imgPath = "assets/night.jpg";

            if (mainWeather.contains('rain')) {
              imgPath = "assets/rainy.jpg";
            } else if (mainWeather.contains('sun')) {
              imgPath = "assets/sunny.jpg";
            } else if (mainWeather.contains('cloud')) {
              imgPath = "assets/cloudy.jpg";
            }

            return Stack(
              children: [
                Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weather.city.capitalizeString(),
                              style: const TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              weather.desc.capitalizeString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${weather.temp.toStringAsFixed(0)}℃",
                              style: const TextStyle(
                                fontSize: 70,
                                color: Colors.white,
                                height: 0.5,
                              ),
                            ),
                            Row(
                              children: [
                                Image.network(
                                  'https://openweathermap.org/img/wn/${weather.icon}.png',
                                  width: 60,
                                  height: 60,
                                ),
                                Text(
                                  weather.main,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );

            // return Center(
            //   child: Text(state.weather.main.capitalizeString()),
            // );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
