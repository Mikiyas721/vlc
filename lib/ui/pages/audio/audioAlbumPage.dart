import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/url.dart';
import '../../../ui/customWidget/audioControlls.dart';
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
                  return AudioControls();
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
            bloc.onAudioTap(audio.mediaFile.path);
          }));
    }
    return elements;
  }
}
