import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/todo/todo_cubit.dart';
import 'manageTodo.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({required this.todo, super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: IconButton(
            onPressed: () => context.read<TodoCubit>().toggleTodo(todo.id),
            icon: Icon(
              todo.isDone
                  ? Icons.check_circle_outline_rounded
                  : Icons.circle_outlined,
              color: todo.isDone ? Colors.green : Colors.grey,
            ),
          ),
          title: Text(
            todo.title,
            style: todo.isDone
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  )
                : const TextStyle(),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  builder: (ctx) => ManageTodo(todo: todo),
                ),
                icon: const Icon(Icons.edit_rounded),
              ),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: const Text("Are you sure"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "CANCEL",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<TodoCubit>().removeTodo(todo.id);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "YES",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
