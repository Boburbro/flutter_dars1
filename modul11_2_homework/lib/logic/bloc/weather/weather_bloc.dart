import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../data/models/weather.dart';
import '../../repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {


    on<WeatherLoadingEvent>((WeatherLoadingEvent event, Emitter emit) async {
      emit(WeatherLoading());
      final weather = await weatherRepository.getWeather(event.city);
      final weatherList = await weatherRepository.getWeeklyWeather(event.city);
      emit(WeatherLoaded(weather: weather, weatherList: weatherList));
    });

    on<CityLoadingEvent>((CityLoadingEvent event, Emitter emit) async {
      emit(WeatherLoading());
      emit(CityLoading());
      final city = await weatherRepository.getCity(event.lat, event.lon);
      emit(CityLoaded(city: city));

      final weather = await weatherRepository.getWeather(city);
      final weatherList = await weatherRepository.getWeeklyWeather(city);
      emit(WeatherLoaded(weather: weather, weatherList: weatherList));
    });
  }
}
