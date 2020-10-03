import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';
import '../../bloc/audioBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/currentAudio.dart';

class AudioControls extends StatelessWidget {
  final AudioPlayer _audioPlayer = GetIt.instance.get();
  final bool isPlaying;
  final double value;
  final String url;

  AudioControls({@required this.isPlaying, @required this.value, @required this.url});

  @override
  Widget build(BuildContext context) {
    final AudioBloc bloc = Provider.of<AudioBloc>(context);
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
                        onPressed: () async {
                          bloc.currentAudio = CurrentAudioModel(
                              path: url,
                              isPlaying: false,
                              currentAudioPosition: await _audioPlayer.getCurrentPosition(),
                              audioDuration: await _audioPlayer.getDuration());
                          _audioPlayer.pause();
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          if (url != null) {
                            bloc.currentAudio = CurrentAudioModel(path: url, isPlaying: true);
                            _audioPlayer.resume();
                          } else
                            Toast.show('No Audio file to play', context);
                        },
                      ),
                IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      bloc.currentAudio = CurrentAudioModel(path: url, isPlaying: false);
                      _audioPlayer.stop();
                    }),
              ],
            )
          ],
        ));
  }
}
