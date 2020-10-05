import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:holding_gesture/holding_gesture.dart';
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
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(Duration(milliseconds: currentAudioPosition).toString().split('.')[0]),
                  ),
                  Expanded(
                      child: Text(
                    audioName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                  )),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(Duration(milliseconds: audioTotalDuration).toString().split('.')[0]),
                  )
                ],
              ),
            ),
            Slider(
              onChanged: (double value) async {
                _audioPlayer
                    .seek(Duration(milliseconds: ((await _audioPlayer.getDuration()) * value).toInt()));
              },
              value: currentAudioPosition / audioTotalDuration,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                HoldDetector(
                  child: Icon(Icons.fast_rewind),
                  onHold: () async {
                    _audioPlayer
                        .seek(Duration(milliseconds: (await _audioPlayer.getCurrentPosition()) - 5000));
                  },
                  onTap: () {
                    //TODO Previous Audio
                  },
                  holdTimeout: Duration(milliseconds: 300),
                ),
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
                IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      bloc.currentAudio = CurrentAudioModel(path: path, isPlaying: false, name: audioName);
                      _audioPlayer.stop();
                    }),
                HoldDetector(
                  child: Icon(Icons.fast_forward),
                  onHold: () async {
                    _audioPlayer
                        .seek(Duration(milliseconds: (await _audioPlayer.getCurrentPosition()) + 5000));
                  },
                  onTap: () {
                    //TODO Next Audio
                  },
                  holdTimeout: Duration(milliseconds: 300),
                ),
              ],
            )
          ],
        ));
  }
}
