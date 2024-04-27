import 'package:flutter/material.dart';
import '../../data/models/weather.dart';
import '../../helper/extensions/string_extension.dart';

// ignore: must_be_immutable
class CityPart extends StatelessWidget {
  CityPart({required this.weather, super.key});

  Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
