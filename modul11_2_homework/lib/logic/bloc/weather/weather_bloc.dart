import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../repositories/weather_repository.dart';

import '../../../data/models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {});

    on<WeatherLoadingEvent>((WeatherLoadingEvent event, Emitter emit) async {
      emit(WeatherLoading());
      final weather = await weatherRepository.getWeather(event.city);
      final weatherList = await weatherRepository.getWeeklyWeather(event.city);
      emit(WeatherLoaded(weather: weather, weatherList: weatherList));
    });
  }
}
