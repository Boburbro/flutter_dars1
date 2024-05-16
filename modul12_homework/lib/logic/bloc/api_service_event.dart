part of 'api_service_bloc.dart';

@immutable
sealed class ApiServiceEvent {}

class GetCoursesEvent extends ApiServiceEvent {}
