import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../model/mediaType.dart';
import '../core/jsonModel.dart';

class MediaModel extends JSONModel {
  final String id;
  final String url;
  final File mediaFile;
  final int width;
  final int height;
  final int duration;
  final Size size;
  final MediaType mediaType;

  MediaModel(
      {@required this.id,
      this.url,
      @required this.height,
      @required this.width,
      @required this.size,
      @required this.duration,
      @required this.mediaFile,
      @required this.mediaType})
      : super(id);

  String getName() {
    String path = mediaFile.path;
    List<String> split = path.split('/');
    return split.elementAt(split.length - 1);
  }

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}
