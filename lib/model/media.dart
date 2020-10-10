import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../model/mediaType.dart';
import '../core/jsonModel.dart';

abstract class PathModel extends JSONModel {
  final String path;
  final File mediaFile;

  PathModel({this.path})
      : mediaFile = File(path),
        super(path);

  String getName() {
    List<String> split = path.split('/');
    return split.elementAt(split.length - 1);
  }
}

class MediaModel extends PathModel {
  final String id;
  final int width;
  final int height;
  final int duration;
  final Size size;
  final MediaType mediaType;
  final Uint8List thumbNail;
  final String streamUrl;
  final int orientation; // flutter_exif_rotation: ^0.2.7

  MediaModel(
      {@required this.id,
      @required this.height,
      @required this.width,
      @required this.size,
      @required this.duration,
      @required File file,
      @required this.mediaType,
      @required this.thumbNail,
      this.streamUrl,
      this.orientation = 0})
      : super(path: file.path);

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}

class DevicePathModel extends PathModel {
  final String parentPath;

  DevicePathModel({path, this.parentPath}) : super(path: path);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
