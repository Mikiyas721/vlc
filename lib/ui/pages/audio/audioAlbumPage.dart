import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/currentAudio.dart';
import '../../../ui/customWidget/audioControls.dart';
import '../../../ui/customWidget/myListTIle.dart';
import '../../../model/media.dart';

class AudioAlbumPage extends StatelessWidget {
  final String title;
  final List<MediaModel> albumAudio;

  AudioAlbumPage({Key key, @required this.title, @required this.albumAudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => AudioBloc(),
        builder: (BuildContext context, AudioBloc bloc) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: ListView(
              children: getBody(bloc),
            ),
            bottomSheet: StreamBuilder(
                stream: bloc.playingStream,
                builder: (BuildContext context, AsyncSnapshot<CurrentAudioModel> snapShot) {
                  return AudioControls(
                    isPlaying: snapShot.data == null ? false : snapShot.data.isPlaying,
                    value: 0, url: snapShot.data?.path,
                  );
                }),
          );
        });
  }

  List<Widget> getBody(AudioBloc bloc) {
    List<Widget> elements = [];
    for (MediaModel audio in albumAudio) {
      elements.add(MyListTile(
          leadingIcon: Icons.audiotrack,
          title: audio.getName(),
          onTap: () {
            bloc.onAudioTap(CurrentAudioModel(path: audio.mediaFile.path, isPlaying: true), albumAudio);
          }));
    }
    return elements;
  }
}
