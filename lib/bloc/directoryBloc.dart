import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:vlc/model/media.dart';
import '../dataSource/directoryDataSource.dart';
import '../bloc/audioBloc.dart';

class DirectoryBloc extends AudioPlayersBloc {
  String internalStorage = '/storage/emulated/0';
  DirectoryRepo _directoryRepo = GetIt.instance.get();

  Stream<List<DevicePathModel>> get dirStream =>
      _directoryRepo.getStream<List<DevicePathModel>>((value) => value);

  void loadRootDirectories() {
    List<DevicePathModel> dirs = [DevicePathModel(path: internalStorage)];
    _directoryRepo.updateStream(dirs);
  }

  fetchChildDirs(String path) {
    List<DevicePathModel> dirs = [];
    Stream<FileSystemEntity> children = Directory(path).list();
    children.forEach((child) {
      if (!isHidden(path)) dirs.add(DevicePathModel(path: child.path));
    });
    _directoryRepo.updateStream(dirs);
  }

  bool isHidden(String path) {
    List<String> split = path.split('/');
    return split[split.length - 1].startsWith('.');
  }

  @override
  void dispose() {}
}
