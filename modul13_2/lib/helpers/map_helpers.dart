import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/map_api.dart';

class MapHelpers {
  static String getLocationImage({
    required double latitude,
    required double longitude,
  }) {
    return "https://static-maps.yandex.ru/v1?apikey=$map_api&ll=$longitude,$latitude&long=en_US&scale=1.5&z=18&spn=0.016457,0.00619";
  }

  static Future<String> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    Uri url = Uri.parse(
        "https://geocode-maps.yandex.ru/1.x/?apikey=$geocoder_api&geocode=$longitude,$latitude&lang=en_US&format=json");
    final response = await http.get(url);
    final responseData = jsonDecode(response.body);

 

    return responseData['response']['GeoObjectCollection']['featureMember'][0]
          ['GeoObject']['metaDataProperty']['GeocoderMetaData']['text'];
  }
}
