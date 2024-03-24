import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocs/active_todos/active_todos_bloc.dart';
import '../../logic/blocs/completed_todos/completed_todos_bloc.dart';
import '../../logic/blocs/todo/todo_bloc.dart';

import '../../data/constants/tab_titles.dart';
import '../widgets/manageTodo.dart';
import '../widgets/search_bar.dart';
import '../widgets/todo_list_item.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  var isinitialized = false;

  @override
  void didChangeDependencies() {
    if (!isinitialized) {
      context.read<TodoBloc>().add(TodoLoadedEvent());
      context.read<ActiveTodosBloc>().add(LoadActiveTodosEvent());
      context.read<CompletedTodosBloc>().add(CompletedTodosLoadedEvent());
      isinitialized = true;
    }
    super.didChangeDependencies();
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: MySearchBar());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabTitle.titles.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TodoScrees"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => openSearchBar(context),
                icon: const Icon(Icons.search_rounded)),
            IconButton(
              onPressed: () => showModalBottomSheet(
                isDismissible: false,
                context: context,
                builder: (ctx) => const ManageTodo(),
              ),
              icon: const Icon(Icons.add),
            )
          ],
          bottom:
              TabBar(tabs: TabTitle.titles.map((e) => Tab(text: e)).toList()),
        ),
        body: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            context.read<ActiveTodosBloc>().add(LoadActiveTodosEvent());
            context.read<CompletedTodosBloc>().add(CompletedTodosLoadedEvent());
          },
          child: TabBarView(
            children: [
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (ctx, index) => ToDoListItem(
                        todo: state.todos[index],
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<ActiveTodosBloc, ActiveTodosState>(
                builder: (context, state) {
                  if (state is ActiveTodosLoaded) {
                    return state.todos.isEmpty
                        ? const Center(
                            child: Text("No task"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: state.todos.length,
                              itemBuilder: (ctx, index) => ToDoListItem(
                                todo: state.todos[index],
                              ),
                            ),
                          );
                  }
                  return const Center(child: Text("No todos"));
                },
              ),
              BlocBuilder<CompletedTodosBloc, CompletedTodosState>(
                builder: (context, state) {
                  if (state is CompletedTodosLoaded) {
                    return state.todos.isEmpty
                        ? const Center(child: Text("No task"))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: state.todos.length,
                              itemBuilder: (ctx, index) => ToDoListItem(
                                todo: state.todos[index],
                              ),
                            ),
                          );
                  }
                  return const Center();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
