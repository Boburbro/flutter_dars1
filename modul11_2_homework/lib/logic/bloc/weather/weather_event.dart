part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class WeatherLoadingEvent extends WeatherEvent {
  final String city;
  WeatherLoadingEvent({required this.city});
}

class CityLoadingEvent extends WeatherEvent {
  final double lat;
  final double lon;
  CityLoadingEvent({required this.lat, required this.lon});
}

