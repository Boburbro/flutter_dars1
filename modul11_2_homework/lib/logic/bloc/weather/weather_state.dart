part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final Weather weather;
  final List<Weather> weatherList;

  WeatherLoaded({required this.weather, required this.weatherList});
}

final class WeatherError extends WeatherState {}
