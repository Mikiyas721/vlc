import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/jsonModel.dart';
import 'media.dart';

class AlbumModel extends JSONModel {
  final String id;
  final String name;
  final int assetCount;
  final List<MediaModel> mediaList;
  final Uint8List thumbNail;
  final double loadProgress;

  AlbumModel(
      {@required this.id,
      @required this.name,
      @required this.assetCount,
      @required this.mediaList,
      @required this.thumbNail,
        this.loadProgress
      })
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
