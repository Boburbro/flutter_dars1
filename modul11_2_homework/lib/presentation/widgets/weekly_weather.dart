import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../logic/bloc/weather/weather_bloc.dart';
import '../../data/models/weather.dart';

import '../screens/menu.dart';
import 'change_city_screen.dart';

class WeeklyWeather extends StatelessWidget {
  const WeeklyWeather({
    required this.weatherList,
    super.key,
  });
  final List<Weather> weatherList;

  // ignore: non_constant_identifier_names
  // void open_add_sheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: const Color(0xFF1C1B33),
  //     context: context,
  //     builder: (ctx) {
  //       return OpenModalBottomSheet();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 325,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2E335A).withAlpha(190),
                  const Color(0xFF1C1B33).withAlpha(190),
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 49,
                  child: Center(
                    child: Text(
                      "Weekly forecast",
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: weatherList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      String imgPath = "assets/icons/tornado.png";

                      if (weatherList[index]
                          .main
                          .toLowerCase()
                          .contains("partly cloudy")) {
                        imgPath = "assets/icons/sun_cloud_angled_rain.png";
                      } else if (weatherList[index]
                          .main
                          .toLowerCase()
                          .contains('patchy rain nearby')) {
                        imgPath = "assets/icons/sun_cloud_rain.png";
                      } else if (weatherList[index]
                          .main
                          .toLowerCase()
                          .contains('sunny')) {
                        imgPath = "assets/icons/sunny.png";
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromARGB(255, 37, 34, 85),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(5, 5),
                                blurRadius: 10,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                DateFormat('EEE').format(
                                    DateTime.parse(weatherList[index].id)),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Image.asset(
                                imgPath,
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              ),
                              Text(
                                "${weatherList[index].temp.toStringAsFixed(0)}°",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final permission =
                                await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied) {
                              await Geolocator.requestPermission();
                            }
                            Position position =
                                await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high,
                            );
                            context.read<WeatherBloc>().add(
                                  CityLoadingEvent(
                                    lat: position.latitude,
                                    lon: position.longitude,
                                  ),
                                );
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (ctx, anima, other) {
                                    return ChangeCityScreen();
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 1000),
                                  reverseTransitionDuration:
                                      const Duration(milliseconds: 200),
                                  transitionsBuilder:
                                      (ctx, anima, other, child) {
                                    anima = CurvedAnimation(
                                      parent: anima,
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      reverseCurve: Curves.fastOutSlowIn,
                                    );
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizeTransition(
                                        sizeFactor: anima,
                                        axisAlignment: 0,
                                        child: ChangeCityScreen(),
                                      ),
                                    );
                                  }),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            size: 60,
                            color: Colors.blue[900],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => MenuScreen(
                                weatherList: weatherList,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.menu,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
