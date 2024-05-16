import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/courses_loaded_widget.dart';

import '../../logic/bloc/api_service_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ApiServiceBloc>().add(GetCoursesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xush kelibsiz!"),
        centerTitle: true,
      ),
      body: BlocBuilder<ApiServiceBloc, ApiServiceState>(
        builder: ((context, state) {
          if (state is CoursesLoaded) {
            final items = state.courses;
            return CoursesLoadedWidget(items: items);
          } else if (state is CoursesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CoursesError) {
            return Center(child: Text(state.message));
          }
          return Container();
        }),
      ),
    );
  }
}
