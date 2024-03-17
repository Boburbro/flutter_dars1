// ignore_for_file: unused_field, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo.dart';
import '../../logic/todo/todo_cubit.dart';

class ManageTodo extends StatefulWidget {
  final Todo? todo;

  const ManageTodo({this.todo, super.key});

  @override
  State<ManageTodo> createState() => _ManageTodoState();
}

class _ManageTodoState extends State<ManageTodo> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.todo == null) {
        context.read<TodoCubit>().addTodo(_title);
      } else {
        context.read<TodoCubit>().editTodo(
              Todo(
                id: widget.todo!.id,
                title: _title,
                isDone: widget.todo!.isDone,
                userId: widget.todo!.userId,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoAdded || state is TodoAdded) {
          Navigator.of(context).pop();
        } else if (state is TodoError) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.todo == null ? "" : widget.todo!.title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please, enter title";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _title = newValue!;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("CANCEL"),
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text(widget.todo == null ? "Add" : "EDIT"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
