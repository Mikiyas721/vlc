import 'dart:io';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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
        blocFactory: () => DirectoryBloc(),
        builder: (BuildContext context, DirectoryBloc bloc) {
          bloc.loadRootDirectories();
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
                          builder: (BuildContext context, AsyncSnapshot<List<DevicePathModel>> snapShot) {
                            return Text(
                              snapShot.data == null ? '' : getDir(snapShot.data[0].parentPath, bloc),
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ); //TODO Make text slide
                          },
                        ),
                        color: Colors.lightBlue,
                      ),
                      preferredSize: Size.fromHeight(30)),
                ),
                body: StreamBuilder(
                    stream: bloc.dirStream,
                    builder: (BuildContext context, AsyncSnapshot<List<DevicePathModel>> snapShot) {
                      return snapShot.data == null
                          ? Center(child: CircularProgressIndicator())
                          : snapShot.data.length == 1 && snapShot.data[0].path == snapShot.data[0].parentPath
                              ? Center(
                                  child: Text('This directory is empty'),
                                )
                              : ListView(children: getBody(snapShot.data, bloc, context));
                    }),
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
              ),
              onWillPop: () async {
                return bloc.goBack(bloc.currentPathParent);
              });
        });
  }

  List<Widget> getBody(List<DevicePathModel> paths, DirectoryBloc bloc, BuildContext context) {
    List<Widget> widgets = [];
    if (paths != null) {
      paths.forEach((model) {
        widgets.add(MyListTile(
            leadingIcon: isFile(model.path) ? Icons.attach_file : Icons.folder,
            title: getTitle(model.path),
            onTap: () {
              if (isFile(model.path)) {
                String fileType = lookupMimeType(model.path).split('/')[0];
                if (fileType == 'image') {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return MyImageView(imageFile: File(model.path));
                  }));
                } else if (fileType == 'video') {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return MyVideoPlayer(
                      mediaFile: File(model.path),
                      fileName: getTitle(model.path),
                    );
                  }));
                } else if (fileType == 'audio') {
                  bloc.playAudio(model.path);
                } else
                  Toast.show('Can not open this file', context);
              } else
                bloc.fetchChildDirs(model.path);
            }));
      });
    }
    return widgets;
  }

  bool isFile(String path) {
    return path.contains('.');
  }

  String getTitle(String path) {
    if (path == '/storage/emulated/0')
      return 'Internal Storage';
    else {
      return path.split('/').last;
    }
  }

  String getDir(String path, DirectoryBloc bloc) {
    if (path == '/storage/emulated')
      return '/';
    else {
      List<String> split = path.split('/');
      String pathString = '';
      for (int i = 0; i < split.length; i++) {
        if (i <= 3) continue;
        pathString += '${split[i]}/';
      }
      return 'storage/$pathString';
    }
  }
}
