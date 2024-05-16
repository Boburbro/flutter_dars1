// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/course_model.dart';
import '../repositories/api_repository.dart';

part 'api_service_event.dart';
part 'api_service_state.dart';

class ApiServiceBloc extends Bloc<ApiServiceEvent, ApiServiceState> {
  final APIRepository apiRepository;
  ApiServiceBloc({required this.apiRepository}) : super(ApiServiceInitial()) {
    on<ApiServiceEvent>((event, emit) {});
    on<GetCoursesEvent>((event, emit) async {
      try {
        final coursesList = await apiRepository.getCourses();
        emit(CoursesLoaded(courses: coursesList));
      } catch (e) {
        rethrow;
      }
    });
  }
}
