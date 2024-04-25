import '../../data/models/weather.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  final WeatherAPIService weatherAPIService;

  WeatherRepository({required this.weatherAPIService});

  Future<Weather> getWeather(String city) async =>
      await weatherAPIService.getWeather(city);
}
