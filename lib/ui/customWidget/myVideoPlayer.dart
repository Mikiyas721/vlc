import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final File mediaFile;
  final String fileName;

  MyVideoPlayer({this.mediaFile, this.fileName});

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  FlickVideoPlayer _flickVideoPlayer;
  FlickManager _flickManager;

  @override
  void initState() {
    _flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(widget.mediaFile),
        onVideoEnd: () {
          //TODO play next video
          Navigator.pop(context);
        });
    _flickVideoPlayer = FlickVideoPlayer(
      flickManager: _flickManager,
      preferredDeviceOrientation: [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    super.initState();
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
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
              widget.fileName,
              style: TextStyle(color: Colors.white),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            )),
      ),
      body: _flickVideoPlayer,
    );
  }
}
