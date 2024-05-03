import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_bloc.dart';

part 'completed_todos_event.dart';
part 'completed_todos_state.dart';

class CompletedTodosBloc
    extends Bloc<CompletedTodosEvent, CompletedTodosState> {
  final TodoBloc todoBloc;

  CompletedTodosBloc(this.todoBloc) : super(CompletedTodosInitial()) {
    on<CompletedTodosEvent>(_getCompletedTodos);
  }
  void _getCompletedTodos(
      CompletedTodosEvent event, Emitter<CompletedTodosState> emit) {
    final todos =
        todoBloc.state.todos.where((element) => element.isDone).toList();
    emit(CompletedTodosLoaded(todos));
  }
}
