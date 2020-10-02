import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatelessWidget {
  final String videoUrl;
  MyVideoPlayer({this.videoUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FlickVideoPlayer(
        flickManager: FlickManager(videoPlayerController: VideoPlayerController.asset(videoUrl)),
        preferredDeviceOrientation: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      ),
    );
  }
}
