import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getTime() async {
  Uri url = Uri.parse("https://worldtimeapi.org/api/timezone/Asia/Tashkent");
  final response = await http.get(url);
  if (response.statusCode != 200) {
    throw Exception("HTTP error: ${response.reasonPhrase}");
  }
  final body = jsonDecode(response.body);
  return body['datetime'];
}
