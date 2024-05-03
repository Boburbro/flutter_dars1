import 'package:flutter/material.dart';
import '../screens/search_city_screen.dart';
import '../screens/settings_screen.dart';

class WeatherMenu extends StatelessWidget {
  WeatherMenu({required this.getWeather, super.key});

  Function getWeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async {
            final _city =
                await Navigator.of(context).pushNamed(SearchCity.routeName);
            if (_city != null) {
              getWeather(_city as String);
            }
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            )),
      ],
    );
  }
}
