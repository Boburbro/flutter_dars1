import 'package:flutter/material.dart';
import 'package:modul12_homework/data/models/course_model.dart';

class DescScreen extends StatelessWidget {
  const DescScreen({super.key});

  static const routeName = '/desc';

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as CourseModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: course.image,
                child: Image.network(
                  course.image,
                  width: 200,
                  height: 200,
                ),
              ),
              Text(course.desc),
            ],
          ),
        ),
      ),
    );
  }
}
