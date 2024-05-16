import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key});

  static const routeName = "/video-player";

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _yt =
        ModalRoute.of(context)!.settings.arguments as YoutubePlayerController;

    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _yt,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.green,
          topActions: [
            const SizedBox(width: 8),
            Text(_yt.metadata.title),
          ],
        ),
      ),
    );
  }
}
