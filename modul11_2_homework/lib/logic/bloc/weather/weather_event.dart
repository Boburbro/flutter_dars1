part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class WeatherLoadingEvent extends WeatherEvent {
  final String city;
  WeatherLoadingEvent({required this.city});
}

