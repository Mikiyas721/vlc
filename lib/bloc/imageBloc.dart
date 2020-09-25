import 'package:flutter/material.dart';
import 'package:flutter_multimedia_picker/data/MediaFile.dart';
import 'package:flutter_multimedia_picker/fullter_multimedia_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:vlc/core/utils/disposable.dart';
import 'package:vlc/dataSource/imageDataSource.dart';
import 'package:vlc/model/media.dart';

class ImageBloc extends Disposable {
  ImageRepo _imageRepo = GetIt.instance.get();

  get imageStream => _imageRepo.getStream<List<MediaModel>>((value) => value);

  void loadImage() async {
    List<MediaFile> images = await FlutterMultiMediaPicker.getImage();
    if (images != null && images.length > 0) {
      List<MediaModel> imageModels = List();
      images.forEach((image) {
        imageModels.add(MediaModel(mediaId: image.id, mediaPath: image.path));
      });
      _imageRepo.updateStream(imageModels);
    }
  }

  List<Widget> getImages(List<MediaModel> imageModels) {
    List<Image> images = [];
    if (imageModels != null) {
      imageModels.forEach((imageModel) {
        images.add(Image.asset(
          imageModel.mediaPath,
          width: 100,
        ));
      });
    }
    return images;
  }

  @override
  void dispose() {}
}
