import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlc/core/utils/disposable.dart';
import 'package:vlc/dataSource/videoDataSource.dart';
import 'package:vlc/model/video.dart';

class VideoBloc extends Disposable {
  VideoRepo _videoRepo = GetIt.instance.get();
  ImagePicker imagePicker = ImagePicker();

  get videoStream=> _videoRepo.getStream<VideoModel>((value)=>value);

  void loadVideo() async {
    PickedFile videos = await imagePicker.getVideo(source: ImageSource.gallery);
    _videoRepo.updateStream(VideoModel(videos.path));

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
