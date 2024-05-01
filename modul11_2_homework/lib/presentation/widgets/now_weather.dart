import 'package:flutter/material.dart';
import 'package:modul11_2_homework/data/models/weather.dart';

class NowWeather extends StatelessWidget {
  final Weather weather;
  const NowWeather({
    required this.weather,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        SizedBox(
          height: 185,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  weather.city,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  "${weather.temp}°",
                  style: const TextStyle(
                      fontSize: 70, color: Colors.white, height: 0.8),
                ),
                Column(
                  children: [
                    Text(
                      weather.main,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.white, height: 0.8),
                    ),
                    const Text(
                      "H:24° L:18°",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Image.asset(
          "assets/home_house.png",
          fit: BoxFit.cover,
          width: 350,
          height: 350,
        ),
      ],
    );
  }
}
