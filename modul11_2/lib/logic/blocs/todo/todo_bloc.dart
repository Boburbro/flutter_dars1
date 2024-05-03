import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../user/user_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserBloc userBloc;

  TodoBloc(this.userBloc)
      : super(TodoInitial([
          Todo(id: UniqueKey().toString(), title: "Go home", userId: "1"),
          Todo(id: UniqueKey().toString(), title: "Go shopping", userId: "1"),
          Todo(id: UniqueKey().toString(), title: "Go school", userId: "2"),
          Todo(id: UniqueKey().toString(), title: "Back home", userId: "1"),
          Todo(id: UniqueKey().toString(), title: "Read book", userId: "2"),
          Todo(id: UniqueKey().toString(), title: "Buy newspaper", userId: "1"),
        ])) {
    on<TodoLoadedEvent>(_getTodos);
    on<AddNewTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<DeleteTodoEvent>(_removeTodo);
  }

  void _getTodos(TodoLoadedEvent event, Emitter<TodoState> emit) {
    final user = userBloc.currentUser;

    final todos =
        state.todos.where((element) => element.userId == user.id).toList();

    emit(TodoLoaded(todos));
  }

  void _addTodo(AddNewTodoEvent event, Emitter emit) {
    try {
      final user = UserBloc().currentUser;
      state.todos.add(
        Todo(
          id: UniqueKey().toString(),
          title: event.title,
          userId: user.id,
        ),
      );
      emit(TodoLoaded(state.todos));
      emit(TodoAdded(state.todos));
    } catch (e) {
      emit(TodoError("Error occured!", state.todos));
    }
  }

  void _editTodo(EditTodoEvent event, Emitter emit) {
    try {
      state.todos[state.todos
          .indexWhere((element) => element.id == event.todo.id)] = event.todo;
      emit(TodoLoaded(state.todos));
      emit(TodoEdited(state.todos));
    } catch (e) {
      emit(TodoError("Error occured!", state.todos));
    }
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter emit) {
    try {
      final todos = state.todos.map((e) {
        if (e.id == event.id) {
          return Todo(
              id: e.id, title: e.title, isDone: !e.isDone, userId: e.userId);
        }
        return e;
      }).toList();

      emit(TodoToggled(todos));
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError("Error occured!", state.todos));
    }
  }

  void _removeTodo(DeleteTodoEvent event, Emitter emit) {
    state.todos.removeWhere((element) => element.id == event.id);
    emit(TodoDelete(state.todos));
    emit(TodoLoaded(state.todos));
  }

  List<Todo> search(String title) {
    return state.todos
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
  }
}
