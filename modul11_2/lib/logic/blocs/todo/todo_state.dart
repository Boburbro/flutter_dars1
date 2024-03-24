part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  final List<Todo> todos;

  const TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  const TodoInitial(super.todos);
}

final class TodoAdded extends TodoState {
  const TodoAdded(super.todos);
}

final class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded(this.todos) : super(todos);
}


final class TodoEdited extends TodoState {
  const TodoEdited(super.todos);
}

final class TodoToggled extends TodoState {
  const TodoToggled(super.todos);
}

final class TodoDelete extends TodoState {
  const TodoDelete(super.todos);
}

final class TodoError extends TodoState {
  final String message;
  const TodoError(this.message, super.todos);
}
