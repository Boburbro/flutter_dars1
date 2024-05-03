import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/settings/settings_cubit.dart';
import '../../data/models/weather.dart';

// ignore: must_be_immutable
class Temperature extends StatefulWidget {
  Temperature({required this.weather, super.key});

  Weather weather;

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  String _getTemp(double temp) {
    final tempUnit = context.watch<SettingsCubit>().state.tempUnits;

    if (tempUnit == TempUnits.fahrenheit) {
      return "${((temp * 9 / 5) + 32).toStringAsFixed(0)}℉";
    }
    return "${temp.toStringAsFixed(0)}℃";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getTemp(widget.weather.temp - 273.15),
          style: const TextStyle(
            fontSize: 70,
            color: Colors.white,
            height: 0.5,
          ),
        ),
        Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${widget.weather.icon}.png',
              width: 60,
              height: 60,
            ),
            Text(
              widget.weather.main,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
