// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final YoutubePlayerController yt;
  final List videos;
  final String initialVideoId;

  // ignore: use_key_in_widget_constructors
  const VideoPlayer({
    required this.yt,
    required this.videos,
    required this.initialVideoId,
  });

  static const routeName = "/video-player";

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  String playingId = '';

  @override
  Widget build(BuildContext context) {
    var yt = widget.yt;
    var les = widget.videos;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            YoutubePlayer(
              controller: yt,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.green,
              topActions: [
                const SizedBox(width: 8),
                Text(yt.metadata.title),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: les.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemBuilder: (ctx, index) {
                  final videoId = YoutubePlayer.convertUrlToId(les[index]);
                  return InkWell(
                    onTap: () {
                      if (videoId != playingId) {
                        yt.load(videoId);
                        setState(() {
                          playingId = videoId;
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showMaterialBanner(MaterialBanner(
                          content: const Text("Siz shu videoni ko'ryabsiz!"),
                          actions: [
                            TextButton(
                              onPressed: () => ScaffoldMessenger.of(context)
                                  .clearMaterialBanners(),
                              child: const Text('x'),
                            )
                          ],
                        ));
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ListTile(
                          leading: Image.network(
                            YoutubePlayer.getThumbnail(videoId: videoId!),
                            fit: BoxFit.cover,
                          ),
                          title: Text("${index + 1}-dars"),
                          trailing: playingId.isEmpty
                              ? videoId == yt.initialVideoId
                                  ? const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.blue,
                                    )
                                  : null
                              : videoId == playingId
                                  ? const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.blue,
                                    )
                                  : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: SizedBox(
          child: Row(
            children: [
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: CupertinoColors.systemBlue,
                ),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              CupertinoTheme(
                data: const CupertinoThemeData(
                  primaryColor: CupertinoColors.systemBlue,
                ),
                child: CupertinoButton.filled(
                  child: Text(
                    'Keyingi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.sourceCodePro().fontFamily,
                    ),
                  ),
                  onPressed: () {
                    List _n = [];
                    for (var n in les) {
                      _n.add(YoutubePlayer.convertUrlToId(n));
                    }
                    int _index = _n.indexOf(playingId);

                    if (_index + 1 != _n.length) {
                      var newvideo = _n[_index + 1];
                      yt.load(newvideo);
                      setState(() {
                        playingId = newvideo;
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                          .showMaterialBanner(MaterialBanner(
                        content: const Text("Siz shu video eng oxirgisi!"),
                        actions: [
                          TextButton(
                            onPressed: () => ScaffoldMessenger.of(context)
                                .clearMaterialBanners(),
                            child: const Text('x'),
                          )
                        ],
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
