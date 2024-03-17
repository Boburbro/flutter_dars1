import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(user: User(id: "user1", name: "Tursinxon")));

  User get currentUser {
    return state.user!;
  }
}
