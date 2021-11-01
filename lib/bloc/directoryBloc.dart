import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mime/mime.dart';
import 'package:toast/toast.dart';
import 'package:vlc/model/mediaType.dart';
import 'package:vlc/ui/customWidget/myImageView.dart';
import 'package:vlc/ui/customWidget/myVideoPlayer.dart';
import '../model/currentAudio.dart';
import '../model/media.dart';
import '../dataSource/directoryDataSource.dart';
import '../bloc/audioBloc.dart';

class DirectoryBloc extends AudioPlayersBloc {
  DirectoryBloc(BuildContext context) : super(context);

  String internalStorage = '/storage/emulated/0';
  DirectoryRepo _directoryRepo = GetIt.instance.get();

  Stream<List<DevicePathModel>> get dirStream =>
      _directoryRepo.getStream<List<DevicePathModel>>((value) => value);

  String get currentPathParent => _directoryRepo.dataStream.value[0].parentPath;

  void loadRootDirectories() {
    List<DevicePathModel> dirs = [
      DevicePathModel(path: internalStorage, parentPath: '/storage/emulated')
    ];
    _directoryRepo.updateStream(dirs);
  }

  fetchChildDirs(String path) {
    List<DevicePathModel> dirs = [];
    if (path == '/storage/emulated')
      _directoryRepo.updateStream([
        DevicePathModel(path: internalStorage, parentPath: '/storage/emulated')
      ]);
    else {
      Directory(path).list().listen((child) {
        if (!isHidden(path))
          dirs.add(DevicePathModel(path: child.path, parentPath: path));
      }, onDone: () {
        dirs = dirs.isEmpty
            ? [DevicePathModel(path: path, parentPath: path)]
            : dirs;
        _directoryRepo.updateStream(dirs);
      });
    }
  }

  bool goBack() {
    if (currentPathParent == '/storage/emulated') return true;
    List<String> split = currentPathParent.split('/');
    String pathBack = '';
    for (int i = 1; i < split.length - 1; i++) {
      pathBack += '/${split[i]}';
    }
    fetchChildDirs(pathBack);
    return false;
  }

  bool isHidden(String path) => path.split('/').last.startsWith('.');

  void playAudio(String path) {
    try {
      audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAudioTap. No audio file to stop playing');
    }
    audioPlayer.play(path);
    historyRepo.addToHistory(path, MediaType.AUDIO);
    final model = DevicePathModel(path: path);
    positionChangeListen(path: path);
    this.currentAudio = CurrentAudioModel(
        path: path, isPlaying: true, name: model.getName(), isStopped: false);
  }

  void onDirectoryTap(DevicePathModel models, int index) async {
    if (isFile(models.path)) {
      String fileType = lookupMimeType(models.path).split('/')[0];
      if (fileType == 'image') {
        final image = File(models.path);
        final decodedImage = await decodeImageFromList(image.readAsBytesSync());
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MyImageView(
            family: [
              MediaModel(
                  height: decodedImage.height,
                  width: decodedImage.width,
                  file: image)
            ],
            currentPictureIndex: 0,
          );
        }));
      } else if (fileType == 'video') {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MyVideoPlayer(
            family: [models],
            currentVideoIndex: index,
          );
        }));
      } else if (fileType == 'audio') {
        playAudio(models.path);
      } else
        Toast.show('Can not open this file', context);
    } else
      fetchChildDirs(models.path);
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

  @override
  void dispose() {
    _directoryRepo.dataStream.close();
  }
}
