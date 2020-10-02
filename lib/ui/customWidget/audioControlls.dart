import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AudioControls extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final bool isPlaying;
  final double value;

  AudioControls(
      {@required this.isPlaying,
      @required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LinearProgressIndicator(
              value: value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                isPlaying
                    ? IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: (){},
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: (){},
                      ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: (){}

                ),
              ],
            )
          ],
        ));
  }
}
