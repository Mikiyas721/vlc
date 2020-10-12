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
  final int width;
  final int height;
  final int duration;
  final Size size;
  final MediaType mediaType;
  final Uint8List thumbNail;
  final String streamUrl;
  final int orientation; // flutter_exif_rotation: ^0.2.7

  MediaModel(
      {@required File file,
      @required this.height,
      @required this.width,
      this.size,
      this.duration,
      this.mediaType,
      this.thumbNail,
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
  final DateTime dateTime;
  final MediaType mediaType;

  DevicePathModel({path, this.parentPath, this.mediaType, this.dateTime}) : super(path: path);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
