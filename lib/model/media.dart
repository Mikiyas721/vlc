import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../core/jsonModel.dart';

class MediaModel extends JSONModel {
  final String mediaId;
  final String mediaPath;
  final File imageFile;
  final int width;
  final int height;
  final int duration;

  MediaModel({@required this.mediaId, @required this.mediaPath, this.height, this.width, this.duration, this.imageFile})
      : super(mediaId);

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}
