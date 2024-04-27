part of 'settings_cubit.dart';

enum TempUnits {
  celcius,
  fahrenheit,
}

@immutable
class SettingsState {
  SettingsState({required this.tempUnits});

  final TempUnits? tempUnits;
}
