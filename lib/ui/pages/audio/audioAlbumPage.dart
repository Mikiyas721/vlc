import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../../ui/customWidget/myPlaylistSelectionDialog.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/currentAudio.dart';
import '../../../ui/customWidget/audioControls.dart';
import '../../../ui/customWidget/myListTIle.dart';
import '../../../model/media.dart';

class AudioAlbumPage extends StatelessWidget {
  final String title;
  final List<PathModel> albumAudio;
  final bool isPlaylist;

  AudioAlbumPage({Key key, @required this.title, @required this.albumAudio, this.isPlaylist = false})
      : super(key: key);

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
                children: getAlbumBody(bloc, context),
              ),
            ),
            bottomSheet: StreamBuilder(
                stream: bloc.playingStream,
                builder: (BuildContext context, AsyncSnapshot<CurrentAudioModel> snapShot) {
                  return snapShot.data == null
                      ? null
                      : snapShot.data.isStopped
                          ? null
                          : AudioControls(
                              isPlaying: snapShot.data.isPlaying,
                              currentAudioPosition: snapShot.data.currentAudioPosition,
                              audioTotalDuration: snapShot.data.audioDuration,
                              path: snapShot.data.path,
                              family: snapShot.data.family,
                              currentAudioIndex: snapShot.data.currentAudioIndex,
                              audioName: snapShot.data.name,
                            );
                }),
          );
        });
  }

  List<Widget> getAlbumBody(AudioBloc bloc, BuildContext context) {
    List<Widget> elements = [];
    for (int i = 0; i < albumAudio.length; i++) {
      elements.add(MyListTile(
        leadingIcon: Icons.audiotrack,
        title: albumAudio[i].getName(),
        path: albumAudio[i].path,
        onTap: () {
          bloc.onAudioTap(albumAudio, i);
        },
        onAddAudioTap: isPlaylist
            ? null
            : () {
                List<String> playlists = bloc.getPlaylists;
                playlists == null
                    ? Toast.show('There are no playlists. Please first create a playlist', context)
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyPlaylistSelectionDialog(
                            options: playlists,
                            onOKClicked: (List<CheckValue> checkValues) {
                              bloc.onAddAudioToPlaylistTap(checkValues, albumAudio[i].path);
                            },
                          );
                        });
              },
      ));
    }
    return elements;
  }
}
