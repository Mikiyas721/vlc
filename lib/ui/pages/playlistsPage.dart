import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../model/currentAudio.dart';
import '../../ui/customWidget/audioControls.dart';
import '../../model/media.dart';
import '../../ui/pages/audio/audioAlbumPage.dart';
import '../../bloc/playlistBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/audioAlbum.dart';
import '../../ui/customWidget/myTextFieldDialog.dart';
import '../../ui/customWidget/myDrawer.dart';

class PlayListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocFactory: () => PlayListBloc(),
      builder: (BuildContext context, PlayListBloc bloc) {
        bloc.loadPlayLists();
        return Scaffold(
          drawer: MyDrawer(isPlaylistSelected: true),
          appBar: AppBar(
            title: Text('Playlists'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyTextFieldDialog(
                            onOKClicked: bloc.onOkClicked,
                          );
                        });
                  })
            ],
          ),
          body: StreamBuilder(
            stream: bloc.playlistStream,
            builder: (BuildContext context, AsyncSnapshot<List<DevicePathModel>> snapshot) {
              bloc.loadPlayLists();
              return snapshot.data == null
                  ? Center(child: CircularProgressIndicator())
                  : (snapshot.data.isEmpty
                      ? Center(
                          child: Text('No Playlist found'),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          children: getBody(snapshot.data, bloc, context),
                        ));
            },
          ),
          bottomSheet: StreamBuilder(
              stream: bloc.playingStream,
              builder: (BuildContext context, AsyncSnapshot<CurrentAudioModel> snapShot) {
                return snapShot.data == null
                    ? Container(height:0, width:0)
                    : snapShot.data.isStopped
                        ? Container(height:0, width:0)
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
      },
    );
  }

  List<Widget> getBody(List<DevicePathModel> list, PlayListBloc bloc, BuildContext context) {
    List<Widget> body = [];
    list.forEach((element) {
      body.add(AudioAlbum(
          albumName: element.value,
          onPlayPressed: () {
            if (bloc.onPlaylistPlay(element.value)) Toast.show('No Track to play', context);
          },
          onAlbumTap: () {
            List<DevicePathModel> tracks = bloc.onPlayListTap(element.value);
            if (tracks == null)
              Toast.show('No Tracks in this Playlist', context);
            else {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return AudioAlbumPage(
                  title: element.value,
                  albumAudio: tracks,
                  isPlaylist: true,
                );
              }));
            }
          }));
    });
    return body;
  }
}
