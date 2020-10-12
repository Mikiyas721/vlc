import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vlc/model/mediaType.dart';
import '../model/currentAudio.dart';
import '../model/media.dart';
import '../dataSource/directoryDataSource.dart';
import '../bloc/audioBloc.dart';

class DirectoryBloc extends AudioPlayersBloc {
  String internalStorage = '/storage/emulated/0';
  DirectoryRepo _directoryRepo = GetIt.instance.get();

  Stream<List<DevicePathModel>> get dirStream =>
      _directoryRepo.getStream<List<DevicePathModel>>((value) => value);

  String get currentPathParent => _directoryRepo.dataStream.value[0].parentPath;

  void loadRootDirectories() {
    List<DevicePathModel> dirs = [DevicePathModel(path: internalStorage, parentPath: '/storage/emulated')];
    _directoryRepo.updateStream(dirs);
  }

  fetchChildDirs(String path) {
    List<DevicePathModel> dirs = [];
    if (path == '/storage/emulated')
      _directoryRepo.updateStream([DevicePathModel(path: internalStorage, parentPath: '/storage/emulated')]);
    else {
      Directory(path).list().listen((child) {
        if (!isHidden(path)) dirs.add(DevicePathModel(path: child.path, parentPath: path));
      }, onDone: () {
        dirs = dirs.isEmpty ? [DevicePathModel(path: path, parentPath: path)] : dirs;
        _directoryRepo.updateStream(dirs);
      });
    }
  }

  bool goBack(String path) {
    if (path == '/storage/emulated') return true;
    List<String> split = path.split('/');
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
    this.currentAudio =
        CurrentAudioModel(path: path, isPlaying: true, name: model.getName(), isStopped: false);
  }

  @override
  void dispose() {}
}
