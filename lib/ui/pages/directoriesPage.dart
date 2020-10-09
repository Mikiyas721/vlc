import 'dart:io';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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
          return Scaffold(
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
                          snapShot.data == null
                              ? ''
                              : snapShot.data.isNotEmpty ? getDir(snapShot.data[0].path, bloc) : 'ghj',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        );
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
                      : ListView(children: getBody(snapShot.data, bloc, context));
                }),
          );
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
    if (path == bloc.internalStorage)
      return '/';
    else {
      List<String> split = path.split('/');
      String pathString = '';
      for (int i = 0; i < split.length - 1; i++) {
        if (i <= 3) continue;
        pathString += '${split[i]}/';
      }
      return 'Storage/$pathString';
    }
  }
}
