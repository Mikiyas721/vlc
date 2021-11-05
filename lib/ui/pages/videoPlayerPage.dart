import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../model/media.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  FlickVideoPlayer _flickVideoPlayer;
  FlickManager _flickManager;
  List<PathModel> family;
  int currentIndex;

  @override
  void initState() {
    _flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(family[currentIndex].mediaFile),
        onVideoEnd: () {
          if (currentIndex < family.length - 1) {
            setState(() {
              currentIndex++;
            });
          } else
            Navigator.pop(context);
          //TODO adjust device orientation accordingly
        });
    _flickVideoPlayer = FlickVideoPlayer(
      flickManager: _flickManager,
      preferredDeviceOrientation: [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    currentIndex = map['currentVideoIndex'];
    family = map['family'];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              family[currentIndex].getName(),
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
