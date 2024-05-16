// write a code course ditails screen.

// ignore_for_file: annotate_overrides, camel_case_types

import 'package:flutter/material.dart';
import 'package:modul12_homework/data/models/course_model.dart';
import 'package:modul12_homework/presentation/screens/video_pleyer.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDitailsScreen extends StatelessWidget {
  const CourseDitailsScreen({super.key});

  static const routeName = '/course-details';

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as CourseModel;
    return Scaffold(
      backgroundColor: const Color(0xFF0d1b2a),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _myDelegate(course: course),
            pinned: true,
          ),
          SliverList.builder(
              itemCount: course.lessons.length,
              itemBuilder: (ctx, index) {
                final les = course.lessons;
                final videoId = YoutubePlayer.convertUrlToId(les[index]);
                final yt = YoutubePlayerController(
                  initialVideoId: videoId!,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    forceHD: true,
                  ),
                );
                return InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    VideoPlayer.routeName,
                    arguments: yt,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    child: Card(
                      child: SizedBox(
                        height: 90,
                        child: Center(
                          child: ListTile(
                            leading: Image.network(
                              YoutubePlayer.getThumbnail(videoId: videoId),
                            ),
                            title: Text("${index + 1}-dars"),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class _myDelegate extends SliverPersistentHeaderDelegate {
  final CourseModel course;

  double maxExtent = 350;

  double minExtent = 100;

  _myDelegate({required this.course});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return shrinkOffset <= 290
        ? Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: course.image,
                child: Image.network(
                  course.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              )
            ],
          )
        : AppBar(
            title: Text(course.title),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Hero(
                    tag: course.image,
                    child: Image.network(
                      course.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
            backgroundColor: const Color(0xFF0d1b2a),
            centerTitle: true,
            elevation: 0,
            shadowColor: Colors.transparent,
          );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
