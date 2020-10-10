import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:toast/toast.dart';
import 'package:vlc/model/media.dart';
import '../../bloc/audioBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/currentAudio.dart';

class AudioControls extends StatelessWidget {
  final AudioPlayer _audioPlayer = GetIt.instance.get();
  final bool isPlaying;
  final int currentAudioPosition;
  final int audioTotalDuration;
  final String path;
  final String audioName;
  final List<PathModel> family;
  final int currentAudioIndex;

  AudioControls(
      {@required this.isPlaying,
      @required this.currentAudioPosition,
      @required this.audioTotalDuration,
      @required this.audioName,
      this.path,
      this.family,
      this.currentAudioIndex});

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
              min: 0,
              max: 1,
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
                    if (family != null && currentAudioIndex != null) {
                      int currentAudioIndex = this.currentAudioIndex - 1;
                      bloc.onAudioTap(family, currentAudioIndex);
                    } else
                      Toast.show('Unable to play previous audio', context);
                  },
                  holdTimeout: Duration(milliseconds: 300),
                ),
                isPlaying
                    ? IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () async {
                          bloc.currentAudio = CurrentAudioModel(
                              isPlaying: false,
                              currentAudioPosition: await _audioPlayer.getCurrentPosition(),
                              audioDuration: await _audioPlayer.getDuration(),
                              name: audioName,
                              family: family,
                              currentAudioIndex: currentAudioIndex,
                              isStopped: false);
                          _audioPlayer.pause();
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          if (path != null) {
                            bloc.currentAudio = CurrentAudioModel(
                                family: family,
                                currentAudioIndex: currentAudioIndex,
                                isPlaying: true,
                                name: audioName,
                                isStopped: false);
                            _audioPlayer.resume();
                          } else
                            Toast.show('No Audio file to play', context);
                        },
                      ),
                IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      bloc.currentAudio = CurrentAudioModel(isStopped: true);
                      _audioPlayer.stop();
                    }),
                HoldDetector(
                  child: Icon(Icons.fast_forward),
                  onHold: () async {
                    _audioPlayer
                        .seek(Duration(milliseconds: (await _audioPlayer.getCurrentPosition()) + 5000));
                  },
                  onTap: () {
                    if (family != null && currentAudioIndex != null) {
                      int currentAudioIndex = this.currentAudioIndex + 1;
                      bloc.onAudioTap(family, currentAudioIndex);
                    } else
                      Toast.show('Unable to play previous audio', context);
                  },
                  holdTimeout: Duration(milliseconds: 300),
                ),
              ],
            )
          ],
        ));
  }
}
