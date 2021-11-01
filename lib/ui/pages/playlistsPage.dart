import 'package:flutter/material.dart';
import '../../model/currentAudio.dart';
import '../../ui/customWidget/audioControls.dart';
import '../../model/media.dart';
import '../../bloc/playlistBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/audioAlbum.dart';
import '../../ui/customWidget/myTextFieldDialog.dart';
import '../../ui/customWidget/myDrawer.dart';

class PlayListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocFactory: () => PlayListBloc(context),
      onInit: (PlayListBloc bloc) {
        bloc.loadPlayLists();
      },
      builder: (BuildContext context, PlayListBloc bloc) {
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
            builder: (BuildContext context,
                AsyncSnapshot<List<DevicePathModel>> snapshot) {
              bloc.loadPlayLists();
              return snapshot.data == null
                  ? Center(child: CircularProgressIndicator())
                  : (snapshot.data.isEmpty
                      ? Center(
                          child: Text('No Playlist found'),
                        )
                      : GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return AudioAlbum(
                                albumName: snapshot.data[index].value,
                                onPlayPressed: () {
                                  bloc.onPlaylistPlay(snapshot.data[index].value);
                                },
                                onAlbumTap: () {
                                  bloc.onAlbumTap(snapshot.data[index]);
                                });
                          },
                        ));
            },
          ),
          bottomSheet: StreamBuilder(
              stream: bloc.playingStream,
              builder: (BuildContext context,
                  AsyncSnapshot<CurrentAudioModel> snapShot) {
                return snapShot.data == null
                    ? Container(height: 0, width: 0)
                    : snapShot.data.isStopped
                        ? Container(height: 0, width: 0)
                        : AudioControls(
                            isPlaying: snapShot.data.isPlaying,
                            currentAudioPosition:
                                snapShot.data.currentAudioPosition,
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
}
