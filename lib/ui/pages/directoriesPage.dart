import 'dart:io';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:vlc/model/currentAudio.dart';
import 'package:vlc/ui/customWidget/audioControls.dart';
import '../../ui/customWidget/myImageView.dart';
import '../../ui/customWidget/myVideoPlayer.dart';
import '../../model/media.dart';
import '../../ui/customWidget/myListTIle.dart';
import '../../bloc/directoryBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/myDrawer.dart';

class DirectoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => DirectoryBloc(context),
        onInit: (DirectoryBloc bloc) {
          bloc.loadRootDirectories();
        },
        builder: (BuildContext context, DirectoryBloc bloc) {
          return WillPopScope(
              child: Scaffold(
                drawer: MyDrawer(isDirectoriesSelected: true),
                appBar: AppBar(
                  title: Text('Directories'),
                  bottom: PreferredSize(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        padding: EdgeInsets.only(left: 15, bottom: 3, top: 3),
                        child: StreamBuilder(
                          stream: bloc.dirStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<DevicePathModel>> snapShot) {
                            return Text(
                              snapShot.data == null
                                  ? ''
                                  : bloc.getDir(snapShot.data[0].parentPath, bloc),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ); //TODO Make text slide
                          },
                        ),
                        color: Colors.lightBlue,
                      ),
                      preferredSize: Size.fromHeight(30)),
                ),
                body: StreamBuilder(
                    stream: bloc.dirStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<DevicePathModel>> snapShot) {
                      return snapShot.data == null
                          ? Center(child: CircularProgressIndicator())
                          : snapShot.data.length == 1 &&
                                  snapShot.data[0].path ==
                                      snapShot.data[0].parentPath
                              ? Center(
                                  child: Text('This directory is empty'),
                                )
                              : ListView.builder(
                                  itemCount: snapShot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MyListTile(
                                        leadingIcon:
                                            bloc.isFile(snapShot.data[index].path)
                                                ? Icons.attach_file
                                                : Icons.folder,
                                        title:
                                            bloc.getTitle(snapShot.data[index].path),
                                        onTap: () async {
                                          bloc.onDirectoryTap(
                                              snapShot.data[index], index);
                                        });
                                  },
                                );
                    }),
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
              ),
              onWillPop: () async {
                return bloc.goBack();
              });
        });
  }

}
