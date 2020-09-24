import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatelessWidget {
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
     /* body: FlickVideoPlayer(
        flickManager: FlickManager(videoPlayerController: VideoPlayerController.asset('')),
        preferredDeviceOrientation: [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
      ),*/
    );
  }
}
