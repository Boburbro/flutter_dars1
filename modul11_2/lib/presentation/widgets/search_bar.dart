import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/todo/todo_cubit.dart';

class MySearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          query = '';
        },
        child: const Text('CLEAR'),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.read<TodoCubit>().search(query);
    return todos.isEmpty
        ? const Center(
            child: Text("Can't find todos"),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(todos[index].title),
                );
              },
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
