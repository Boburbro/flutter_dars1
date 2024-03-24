import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_cubit.dart';

part 'active_todos_state.dart';

class ActiveTodosCubit extends Cubit<ActiveTodosState> {
  final TodoCubit todoCubit;
  late final StreamSubscription todoCubitSubscription;

  ActiveTodosCubit(this.todoCubit) : super(ActiveTodosInitial()) {
    todoCubitSubscription = todoCubit.stream.listen((TodoState state) {
      getActive();
    });
  }

  void getActive() {
    final todos =
        todoCubit.state.todos.where((element) => !element.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    todoCubitSubscription.cancel();
    return super.close();
  }
}
