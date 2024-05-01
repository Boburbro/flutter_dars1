import '../../data/models/weather.dart';
import '../services/weather_api_servies.dart';

class WeatherRepository {
  final WeatherAPIService weatherAPIService;

  WeatherRepository({required this.weatherAPIService});
  Future<Weather> getWeather(String city) async =>
      await weatherAPIService.getWeather(city);

  Future<List<Weather>> getWeeklyWeather(String city) async =>
      await weatherAPIService.getWeeklyWeather(city);

  Future<String> getCity(double lat, double lon) async =>
      await weatherAPIService.getCity(lat, lon);
}
