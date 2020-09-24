import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlc/core/utils/disposable.dart';
import 'package:vlc/dataSource/imageDataSource.dart';
import 'package:vlc/model/video.dart';

class ImageBloc extends Disposable {
  ImageRepo imageRepo = GetIt.instance.get();
  ImagePicker imagePicker = ImagePicker();

  void loadImage() async {
    PickedFile images = await imagePicker.getImage(source: ImageSource.gallery);
    imageRepo.updateStream(VideoModel(images.path));
  }

  @override
  void dispose() {
  }
}
