import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/constants/constants.dart';
import '../../data/models/weather.dart';
import 'weather_exception.dart';

class WeatherAPIService {
  final http.Client client;

  WeatherAPIService({required this.client});

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse("$base_url?q=${city.toLowerCase()}&appid=$api_key");

    try {
      final response = await client.get(url);
      if (response.statusCode >= 400) {
        throw WeatherExceptions(response.reasonPhrase.toString());
      }
      final responseBody = jsonDecode(response.body);

      if (responseBody == null) {
        throw WeatherExceptions('Cannot get weather for $city');
      }
      final data = responseBody as Map<String, dynamic>;

      final weatherData = data['weather'][0];
      final mainData = data['main'];

      final Weather weather = Weather(
        id: weatherData['id'].toString(),
        main: weatherData['main'],
        desc: weatherData['description'],
        icon: weatherData['icon'],
        temp: double.parse(mainData['temp'].toString()),
        city: city,
      );
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
