import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/blocs/active_todos/active_todos_bloc.dart';
import 'logic/blocs/completed_todos/completed_todos_bloc.dart';
import 'logic/blocs/todo/todo_bloc.dart';
import 'logic/blocs/user/user_bloc.dart';

import 'presentation/screens/todo_scrren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UserBloc(),
        ),
        BlocProvider(create: (ctx) => TodoBloc(ctx.read<UserBloc>())),
        BlocProvider(create: (ctx) => ActiveTodosBloc(ctx.read<TodoBloc>())),
        BlocProvider(create: (ctx) => CompletedTodosBloc(ctx.read<TodoBloc>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ToDoScreen(),
      ),
    );
  }
}
