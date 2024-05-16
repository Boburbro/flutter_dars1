import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modul12_homework/logic/repositories/api_exceptions.dart';

import '../../data/constants/urls.dart';
import '../../data/models/course_model.dart';

class APIService {
  final http.Client client;

  APIService({required this.client});

  Future<List<CourseModel>> getCourses() async {
    final url = Uri.parse("$api_url/courses.json");

    List<CourseModel> coursesList = [];

    try {
      final response = await client.get(url);

      if (response.statusCode >= 400) {
        throw APIException(response.reasonPhrase.toString());
      }

      final responseBody = jsonDecode(response.body) as Map;

      // ignore: no_leading_underscores_for_local_identifiers
      for (var _key in responseBody.keys) {
        coursesList.add(
          CourseModel(
            title: responseBody[_key]['title'],
            desc: responseBody[_key]['desc'],
            image: responseBody[_key]['image'],
            lessons: responseBody[_key]['lessons'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    return coursesList;
  }
}
