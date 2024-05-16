part of 'api_service_bloc.dart';

@immutable
sealed class ApiServiceState {}

final class ApiServiceInitial extends ApiServiceState {}

final class ApiServiceLoading extends ApiServiceState {}

final class CoursesLoaded extends ApiServiceState {
  final List<CourseModel> courses;
  CoursesLoaded({required this.courses});
}
