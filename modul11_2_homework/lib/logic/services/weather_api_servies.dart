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
        maxT: double.parse(
            (double.parse(mainData['temp_max'].toString()) - 275.15)
                .toStringAsFixed(0)),
        minT: double.parse(
            (double.parse(mainData['temp_min'].toString()) - 275.15)
                .toStringAsFixed(0)),
      );
      return weather;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Weather>> getWeeklyWeather(String city) async {
    List<Weather> weatherList = [];

    final url = Uri.parse(
        "$weekly_base_url?key=$weekly_api_key&q=$city&days=7&aqi=no&alerts=no");
    try {
      final respons = await client.get(url);
      if (respons.statusCode >= 400) {
        print(respons.statusCode);
        print(
            "$weekly_base_url?key=$weekly_api_key&q=$city&days=7&aqi=no&alerts=no");
        throw WeatherException(respons.reasonPhrase.toString());
      }

      final responseBody = jsonDecode(respons.body);

      if (responseBody == null) {
        throw WeatherException('CANNOT GET WEEKLY WEATHER FOR $city');
      }

      final data = responseBody as Map<String, dynamic>;

      final weathers = data['forecast']['forecastday'];

      if (weathers.length == 0) {
        throw WeatherException('CANNOT GET WEEKLY WEATHER FOR $city');
      }

      for (final weatherData in weathers) {
        final dataWeather = weatherData['day'];
        weatherList.add(
          Weather(
            id: weatherData['date'],
            main: dataWeather['condition']['text'],
            desc: dataWeather['condition']['text'],
            temp: double.parse(
                ((dataWeather['maxtemp_c'] + dataWeather['mintemp_c']) / 2)
                    .toString()),
            city: city,
            maxT: dataWeather['maxtemp_c'],
            minT: dataWeather['mintemp_c'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }

    return weatherList;
  }

  Future<String> getCity(double lat, double lon) async {
    final url = Uri.parse("$base_url?lat=$lat&lon=$lon&appid=$api_key");

    try {
      final response = await client.get(url);

      if (response.statusCode >= 400) {
        throw WeatherException(response.reasonPhrase.toString());
      }
      final responseBody = jsonDecode(response.body);

      if (responseBody == null) {
        throw WeatherException('CANNOT GET WEATHER FOR lon lat');
      }

      final data = responseBody as Map<String, dynamic>;
      print(data['name']);

      return data['name'];
    } catch (e) {
      rethrow;
    }
  }
}
