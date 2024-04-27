import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modul11_2_1/logic/cubit/settings/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListTile(
        title: const Text("Temperature Unit"),
        subtitle: const Text(
          "Celcius / Fahrenheit (default: Celcius)",
        ),
        trailing: Switch(
          value: context.watch<SettingsCubit>().state.tempUnits ==
                  TempUnits.celcius
              ? true
              : false,
          onChanged: (value) {
            context.read<SettingsCubit>().toggleTemperature();
          },
          activeTrackColor: Colors.green,
        ),
      ),
    );
  }
}
