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
            body: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.33),
              child: ListView(
                children: getBody(bloc),
              ),
            ),
            bottomSheet: StreamBuilder(
                stream: bloc.playingStream,
                builder: (BuildContext context, AsyncSnapshot<CurrentAudioModel> snapShot) {
                  return snapShot.data == null
                      ? AudioControls(
                          isPlaying: false,
                          currentAudioPosition: 0,
                          audioTotalDuration: 1,
                          path: null,
                          audioName: '',
                        )
                      : AudioControls(
                          isPlaying: snapShot.data.isPlaying,
                          currentAudioPosition: snapShot.data.currentAudioPosition,
                          audioTotalDuration: snapShot.data.audioDuration,
                          path: snapShot.data.path,
                          audioName: snapShot.data.name,
                        );
                }),
          );
        });
  }

  List<Widget> getBody(AudioBloc bloc) {
    List<Widget> elements = [];
    for (MediaModel mediaModel in albumAudio) {
      elements.add(MyListTile(
        leadingIcon: Icons.audiotrack,
        title: mediaModel.getName(),
        path: mediaModel.mediaFile.path,
        onTap: () {
          bloc.onAudioTap(mediaModel, albumAudio);
        },
        onAddAudioTap: (){

        },
      ));
    }
    return elements;
  }
}
