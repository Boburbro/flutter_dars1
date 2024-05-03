import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/weather_menu.dart';
import '../widgets/city_part.dart';
import '../widgets/temperature.dart';
import '../../logic/cubit/weather/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getWeather("ferghana");
  }

  void _getWeather(String city) {
    context.read<WeatherCubit>().getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (ctx, state) async {
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
            if (state.message.toLowerCase().contains("not found")) {
              _getWeather('ferghana');
            }
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
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                Positioned(
                  right: 0,
                  top: 30,
                  child: WeatherMenu(getWeather: _getWeather),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CityPart(weather: weather),
                        Temperature(weather: weather),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
