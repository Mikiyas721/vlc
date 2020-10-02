import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';
import 'package:vlc/bloc/galleryBloc.dart';
import '../../../ui/pages/audio/audioAlbumPage.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/album.dart';
import '../../../ui/customWidget/audioAlbum.dart';
import '../../customWidget/myDrawer.dart';

class AudioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocFactory: () => AudioBloc(),
      builder: (BuildContext context, AudioBloc bloc) {
        bloc.loadDeviceAudio();
        return StreamBuilder(
            stream: bloc.deviceAudioStream,
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              return Scaffold(
                drawer: MyDrawer(isAudioSelected: true),
                appBar: AppBar(title: Text('Audio')),
                body: snapShot.data == null
                    ? Center(child: CircularProgressIndicator())
                    : Align(
                        alignment: Alignment.topLeft,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: getGridElements(context, snapShot.data, bloc),
                        ),
                      ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.shuffle),
                  onPressed: () {
                    if (!bloc.onShuffleClicked(snapShot.data)) Toast.show('No Audio file found', context);
                  },
                ),
              );
            });
      },
    );
  }

  List<Widget> getGridElements(BuildContext context, List<AlbumModel> audioModels, AudioBloc bloc) {
    List<Widget> widgets = [];
    for (AlbumModel album in audioModels) {
      widgets.add(AudioAlbum(
          albumName: album.name,
          onPlayPressed: () {
            Toast.show('Randomly Playing from Album ${album.name}', context);
            bloc.onAlbumRandomPlayClicked(album);
          },
          onAlbumTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return AudioAlbumPage(title: album.name, albumAudio: album.mediaList);
            }));
          }));
    }
    return widgets;
  }
}
