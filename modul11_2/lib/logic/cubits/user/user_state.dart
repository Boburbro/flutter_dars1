part of 'user_cubit.dart';

@immutable
sealed class UserState {
  final User? user;

  const UserState({this.user});
}

final class UserInitial extends UserState {
  const UserInitial({super.user});

}
