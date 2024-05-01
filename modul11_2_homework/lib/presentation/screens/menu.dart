import 'package:flutter/material.dart';
import 'package:modul11_2_homework/data/models/weather.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({required this.weatherList, super.key});
  final List<Weather> weatherList;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B33),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1C1B33),
        title: const Text(
          "Weather",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weatherList.length,
        itemBuilder: (ctx, index) {
          String imgPath = "assets/icons/tornado.png";

          if (weatherList[index].main.toLowerCase().contains("partly cloudy")) {
            imgPath = "assets/icons/sun_cloud_angled_rain.png";
          } else if (weatherList[index]
              .main
              .toLowerCase()
              .contains('patchy rain nearby')) {
            imgPath = "assets/icons/sun_cloud_rain.png";
          } else if (weatherList[index].main.toLowerCase().contains('sunny')) {
            imgPath = "assets/icons/sunny.png";
          }
          return SizedBox(
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'assets/widgets/rectangle.png',
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 30,
                  child: Text(
                    "${weatherList[index].temp.toStringAsFixed(0)}°",
                    style: const TextStyle(color: Colors.white, fontSize: 62),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MAX: ${weatherList[index].maxT.toStringAsFixed(0)}° MIN: ${weatherList[index].minT.toStringAsFixed(0)}°",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Text(
                        weatherList[index].city,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20, height: 0.9),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    imgPath,
                    width: 150,
                    height: 150,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
