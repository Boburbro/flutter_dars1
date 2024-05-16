import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/api_service_bloc.dart';
import 'course_ditails_screen.dart';

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
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: BlocBuilder<ApiServiceBloc, ApiServiceState>(
        builder: ((context, state) {
          if (state is CoursesLoaded) {
            final items = state.courses;
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1)).then((value) {
                  context.read<ApiServiceBloc>().add(GetCoursesEvent());
                });
              },
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                itemCount: items.length,
                itemBuilder: (ctx, index) {
                  final course = items[index];
                  return Card(
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: ListTile(
                          onTap: () => Navigator.of(context).pushNamed(
                            CourseDitailsScreen.routeName,
                            arguments: course,
                          ),
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Hero(
                                tag: course.image,
                                child: Image.network(
                                  course.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Text(course.title),
                          subtitle: Text(
                            "Description: ${course.desc}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
