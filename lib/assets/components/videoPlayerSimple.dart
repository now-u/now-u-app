import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class VideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      context: context,
      source: 'y3B8YqeLCpY',
      quality: YoutubeQuality.HIGH,
      // callbackController is (optional). 
      // use it to control player on your own.
    );
  }
}
