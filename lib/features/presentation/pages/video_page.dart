import 'dart:io';

import 'package:capacious/features/domain/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatelessWidget {
  final Video video;
  const VideoPage({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? videoID = YoutubePlayer.convertUrlToId(video.url!);
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          _videoPlayer(videoID),
          Platform.isAndroid ? const SizedBox() : _backButton(context)
        ],
      )),
    );
  }

  Widget _videoPlayer(String? videoID) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoID!,
            flags: const YoutubePlayerFlags(
              hideControls: false,
              controlsVisibleAtStart: true,
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(video.author!,
                  style: const TextStyle(
                    fontSize: 15,
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: Colors.black12,
            padding: const EdgeInsets.all(10)),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
