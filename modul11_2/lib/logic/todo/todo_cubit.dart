import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/todo.dart';
import '../user/user_cubit.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UserCubit userCubit;

  TodoCubit({required this.userCubit})
      : super(TodoInitial([
          Todo(id: UniqueKey().toString(), title: "Go home", userId: "user1"),
          Todo(id: UniqueKey().toString(), title: "Go shopping", userId: "2"),
          Todo(id: UniqueKey().toString(), title: "Go school", userId: "1"),
        ]));

  void getTodos() {
    final user = UserCubit().currentUser;

    final todos =
        state.todos.where((element) => element.userId == user.id).toList();
    emit(TodoState(todos));
  }

  void addTodo(title) {
    try {
      state.todos
          .add(Todo(id: UniqueKey().toString(), title: title, userId: "1"));
      emit(TodoState(state.todos));
      emit(TodoAdded(state.todos));
    } catch (e) {
      emit(TodoError("Error occured!", state.todos));
    }
  }

  void editTodo(Todo todo) {
    try {
      state.todos[state.todos.indexWhere((element) => element.id == todo.id)] =
          todo;
      emit(TodoState(state.todos));
      emit(TodoAdded(state.todos));
    } catch (e) {
      emit(TodoError("Error occured!", state.todos));
    }
  }

  void toggleTodo(String id) {
    try {
      final todos = state.todos.map((e) {
        if (e.id == id) {
          return Todo(
              id: e.id, title: e.title, isDone: !e.isDone, userId: e.userId);
        }
        return e;
      }).toList();

      emit(TodoState(todos));
      emit(TodoToggled(todos));
    } catch (e) {
      emit(TodoError("Error occured!", state.todos));
    }
  }

  void removeTodo(String id) {
    state.todos.removeWhere((element) => element.id == id);
    emit(TodoState(state.todos));
    emit(TodoRemove(state.todos));
  }

  List<Todo> search(String title) {
    return state.todos
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
