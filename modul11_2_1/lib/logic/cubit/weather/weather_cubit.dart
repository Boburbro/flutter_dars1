import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:modul11_2_1/data/models/weather.dart';
import 'package:modul11_2_1/logic/repositories/weather_repostory.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository}) : super(WeatherInitial());

  Future<void> getWeather(String city) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getWeather(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
