import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';
import '../../core/mixins/dateTime.dart';
import '../../bloc/audioBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/currentAudio.dart';

class AudioControls extends StatelessWidget with DateTimeMixin {
  final AudioPlayer _audioPlayer = GetIt.instance.get();
  final bool isPlaying;
  final int currentAudioPosition;
  final int audioTotalDuration;
  final String path;
  final String audioName;

  AudioControls(
      {@required this.isPlaying,
      @required this.currentAudioPosition,
      @required this.audioTotalDuration,
      @required this.path,
      @required this.audioName});

  @override
  Widget build(BuildContext context) {
    final AudioBloc bloc = Provider.of<AudioBloc>(context);
    return Card(
        margin: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(Duration(milliseconds: currentAudioPosition).toString().split('.')[0]),
                  Spacer(),
                  Text(Duration(milliseconds: audioTotalDuration).toString().split('.')[0]),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: currentAudioPosition / audioTotalDuration,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 5)),
                Expanded(
                    child: Text(
                  audioName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                )),
                isPlaying
                    ? IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () async {
                          bloc.currentAudio = CurrentAudioModel(
                              path: path,
                              isPlaying: false,
                              currentAudioPosition: await _audioPlayer.getCurrentPosition(),
                              audioDuration: await _audioPlayer.getDuration(),
                              name: audioName);
                          _audioPlayer.pause();
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          if (path != null) {
                            bloc.currentAudio =
                                CurrentAudioModel(path: path, isPlaying: true, name: audioName);
                            _audioPlayer.resume();
                          } else
                            Toast.show('No Audio file to play', context);
                        },
                      ),
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 5),
                  child: IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () {
                        bloc.currentAudio = CurrentAudioModel(path: path, isPlaying: false, name: audioName);
                        _audioPlayer.stop();
                      }),
                ),
              ],
            )
          ],
        ));
  }
}
