import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/todo.dart';
import '../todo/todo_bloc.dart';

part 'active_todos_event.dart';
part 'active_todos_state.dart';

class ActiveTodosBloc extends Bloc<ActiveTodosEvent, ActiveTodosState> {
  final TodoBloc todoBloc;

  ActiveTodosBloc(this.todoBloc) : super(ActiveTodosInitial()) {
    on<LoadActiveTodosEvent>(_getActive);
  }
  void _getActive(LoadActiveTodosEvent event, Emitter<ActiveTodosState> emit) {
    final todos =
        todoBloc.state.todos.where((element) => !element.isDone).toList();
    emit(ActiveTodosLoaded(todos));
  }
}
