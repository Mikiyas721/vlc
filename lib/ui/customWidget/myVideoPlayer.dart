import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:vlc/model/media.dart';

class MyVideoPlayer extends StatefulWidget {
  final List<PathModel> family;
  final int currentVideoIndex;

  MyVideoPlayer({this.family, this.currentVideoIndex});

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  FlickVideoPlayer _flickVideoPlayer;
  FlickManager _flickManager;
  PathModel currentVideo;
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.currentVideoIndex;
    currentVideo = widget.family[currentIndex];
    _flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(currentVideo.mediaFile),
        onVideoEnd: () {
          if (currentIndex < widget.family.length - 1) {
            setState(() {
              currentIndex++;
            });
          } else
            Navigator.pop(context);
          //TODO adjust device orientation accordingly
        });
    _flickVideoPlayer = FlickVideoPlayer(
      flickManager: _flickManager,
      preferredDeviceOrientation: [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              currentVideo.getName(),
              style: TextStyle(color: Colors.white),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            )),
      ),
      body: _flickVideoPlayer,
    );
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }
}
