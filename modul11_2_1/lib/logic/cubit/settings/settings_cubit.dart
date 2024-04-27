import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(tempUnits: TempUnits.celcius));

  void toggleTemperature() {
    if (state.tempUnits == TempUnits.celcius) {
      emit(SettingsState(tempUnits: TempUnits.fahrenheit));
    } else {
      emit(SettingsState(tempUnits: TempUnits.celcius));
    }
  }
}
