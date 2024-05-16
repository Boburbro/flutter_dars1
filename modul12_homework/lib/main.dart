import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:modul12_homework/presentation/screens/video_pleyer.dart';

import 'logic/bloc/api_service_bloc.dart';
import 'logic/repositories/api_repository.dart';
import 'logic/services/api_service.dart';
import 'presentation/screens/course_ditails_screen.dart';
import 'presentation/screens/home_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => APIRepository(
        apiService: APIService(
          client: Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ApiServiceBloc(
              apiRepository: context.read<APIRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "AsSoft",
          initialRoute: HomeScreen.routeName,
          theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: GoogleFonts.prompt().fontFamily,
          ),
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            CourseDitailsScreen.routeName: (ctx) => const CourseDitailsScreen(),
            VideoPlayer.routeName: (ctx) => const VideoPlayer(),
          },
        ),
      ),
    );
  }
}
