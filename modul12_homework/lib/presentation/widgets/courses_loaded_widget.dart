import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/course_model.dart';
import '../../logic/bloc/api_service_bloc.dart';
import '../screens/course_ditails_screen.dart';

class CoursesLoadedWidget extends StatelessWidget {
  const CoursesLoadedWidget({
    super.key,
    required this.items,
  });

  final List<CourseModel> items;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          context.read<ApiServiceBloc>().add(GetCoursesEvent());
        });
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
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
}
