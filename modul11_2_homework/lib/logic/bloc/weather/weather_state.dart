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

final class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}

final class CityLoaded extends WeatherState {
  final String city;

  CityLoaded({required this.city});
}

final class CityLoading extends WeatherState {}

final class CityError extends WeatherState {
  final String message;

  CityError({required this.message});
}