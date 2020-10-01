import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vlc/model/mediaType.dart';
import '../core/jsonModel.dart';

class MediaModel extends JSONModel {
  final String id;
  final String path;
  final File imageFile;
  final int width;
  final int height;
  final int duration;
  final Size size;
  final MediaType mediaType;

  MediaModel(
      {@required this.id,
      this.path,
      @required this.height,
      @required this.width,
      @required this.size,
      @required this.duration,
      @required this.imageFile,
      @required this.mediaType})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}
