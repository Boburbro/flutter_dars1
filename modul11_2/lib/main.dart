import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/active_todos/active_todos_cubit.dart';
import 'logic/completed_todos/completed_todos_cubit.dart';

import 'logic/todo/todo_cubit.dart';
import 'logic/user/user_cubit.dart';
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
        BlocProvider(create: (ctx) => UserCubit()),
        BlocProvider(
            create: (ctx) => TodoCubit(userCubit: ctx.read<UserCubit>())),
        BlocProvider(create: (ctx) => ActiveTodosCubit(ctx.read<TodoCubit>())),
        BlocProvider(
            create: (ctx) => CompletedTodosCubit(ctx.read<TodoCubit>())),
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
