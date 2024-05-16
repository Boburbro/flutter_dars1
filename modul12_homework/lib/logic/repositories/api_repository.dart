import '../../data/models/course_model.dart';
import '../services/api_service.dart';

class APIRepository {
  final APIService apiService;

  APIRepository({required this.apiService});

  Future<List<CourseModel>> getCourses() async =>
      await apiService.getCourses();
}
