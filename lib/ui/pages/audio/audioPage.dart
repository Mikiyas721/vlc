import 'package:flutter/material.dart';
import '../../../model/currentAudio.dart';
import '../../../ui/customWidget/audioControls.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/album.dart';
import '../../../ui/customWidget/audioAlbum.dart';
import '../../customWidget/myDrawer.dart';

class AudioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocFactory: () => AudioBloc(context),
      onInit: (AudioBloc bloc) {
        bloc.loadDeviceAudio();
      },
      builder: (BuildContext context, AudioBloc bloc) {
        return StreamBuilder(
            stream: bloc.deviceAudioStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<AlbumModel>> snapShot) {
              return Scaffold(
                drawer: MyDrawer(isAudioSelected: true),
                appBar: AppBar(
                  title: Text('Audio'),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.shuffle),
                        onPressed: () {
                          bloc.onShuffleClicked(snapShot.data);
                        })
                  ],
                ),
                body: snapShot.data == null
                    ? Center(child: CircularProgressIndicator())
                    : Align(
                        alignment: Alignment.topLeft,
                        child: GridView.builder(
                          itemCount: snapShot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return AudioAlbum(
                              albumName: snapShot.data[index].name,
                              onPlayPressed: () {
                                bloc.onAlbumRandomPlayClicked(
                                    snapShot.data[index]);
                              },
                              onAlbumTap: () {
                                bloc.onAlbumTap(snapShot.data[index]);
                              },
                              onAlbumAdd: () {
                                bloc.onAlbumAdd(snapShot.data[index]);
                              },
                            );
                          },
                        ),
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
                                  audioTotalDuration:
                                      snapShot.data.audioDuration,
                                  path: snapShot.data.path,
                                  family: snapShot.data.family,
                                  currentAudioIndex:
                                      snapShot.data.currentAudioIndex,
                                  audioName: snapShot.data.name,
                                );
                    }),
              );
            });
      },
    );
  }
}
