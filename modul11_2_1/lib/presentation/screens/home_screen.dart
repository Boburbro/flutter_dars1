import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modul11_2_1/logic/cubit/weather/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<WeatherCubit>().getWeather("london");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
      ),
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
            return Center(
              child: Text(state.weather.main),
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
