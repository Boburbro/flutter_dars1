import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/constants/constants.dart';
import '../../data/models/weather.dart';
import 'weather_exceptions.dart';

class WeatherAPIService {
  final http.Client client;

  WeatherAPIService({required this.client});
  Future<Weather> getWeather(String city) async {
    final url = Uri.parse("$base_url?q=${city.toLowerCase()}&appid=$api_key");

    try {
      final response = await client.get(url);
      if (response.statusCode >= 400) {
        throw WeatherException(response.reasonPhrase.toString());
      }
      final responseBody = jsonDecode(response.body);

      print(responseBody);

      if (responseBody == null) {
        throw WeatherException('CANNOT GET WEATHER FOR $city');
      }

      final data = responseBody as Map<String, dynamic>;

      final weatherData = data['weather'][0];
      final mainData = data['main'];

      final Weather weather = Weather(
        id: weatherData['id'].toString(),
        main: weatherData['main'],
        desc: weatherData['description'],
        temp: double.parse((double.parse(mainData['temp'].toString()) - 275.15)
            .toStringAsFixed(0)),
        city: city,
      );
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
