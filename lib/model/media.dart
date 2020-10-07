import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../model/mediaType.dart';
import '../core/jsonModel.dart';

class MediaModel extends JSONModel {
  final String id;
  final File mediaFile;
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
      @required this.mediaFile,
      @required this.mediaType,
      @required this.thumbNail,
      this.streamUrl,
      this.orientation = 0})
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
