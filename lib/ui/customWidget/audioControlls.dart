import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';

class AudioControls extends StatefulWidget {
  final AudioPlayer audioPlayer = GetIt.instance.get();
  final String url;

  AudioControls({@required this.url});

  @override
  _AudioControlsState createState() => _AudioControlsState();
}

class _AudioControlsState extends State<AudioControls> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LinearProgressIndicator(
              value: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                isPlaying
                    ? IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () {
                          widget.audioPlayer.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          if (widget.url != null) {
                            widget.audioPlayer.play(widget.url);
                            setState(() {
                              isPlaying = true;
                            });
                          } else {
                            Toast.show('Tap on the music you want to play', context);
                          }
                        },
                      ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    widget.audioPlayer.stop();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }
}
