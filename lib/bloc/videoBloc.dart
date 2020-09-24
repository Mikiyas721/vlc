import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlc/core/utils/disposable.dart';
import 'package:vlc/dataSource/videoDataSource.dart';

class VideoBloc extends Disposable {
  VideoRepo videoRepo = GetIt.instance.get();
  ImagePicker imagePicker = ImagePicker();

  void loadVideo() async {
    PickedFile images = await imagePicker.getImage(source: ImageSource.gallery);

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
