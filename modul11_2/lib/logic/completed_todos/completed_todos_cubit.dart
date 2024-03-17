import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/todo.dart';
import '../todo/todo_cubit.dart';

part 'completed_todos_state.dart';

class CompletedTodosCubit extends Cubit<CompletedTodosState> {
  final TodoCubit todoCubit;
  late final StreamSubscription completedTodoSubscription;

  CompletedTodosCubit(this.todoCubit) : super(CompletedTodosInitial()) {
    completedTodoSubscription = todoCubit.stream.listen((TodoState state) {
      getCompletedTodos();
    });
  }

  void getCompletedTodos() {
    final todos =
        todoCubit.state.todos.where((element) => element.isDone).toList();
    emit(CompletedTodosLoaded(todos));
  }

  @override
  Future<void> close() {
    completedTodoSubscription.cancel();
    return super.close();
  }
}
