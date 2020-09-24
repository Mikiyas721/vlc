import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:vlc/core/utils/disposable.dart';
import 'package:vlc/dataSource/videoDataSource.dart';
import 'package:vlc/model/media.dart';

class VideoBloc extends Disposable {
  VideoRepo _videoRepo = GetIt.instance.get();

  get videoStream=> _videoRepo.getStream<MediaModel>((value)=>value);

  void loadVideo() async {

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
