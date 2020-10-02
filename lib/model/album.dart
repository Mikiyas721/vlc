import 'dart:io';
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

  AlbumModel(
      {@required this.id,
      @required this.name,
      @required this.assetCount,
      @required this.mediaList,
      @required this.thumbNail
      })
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return null;
  }
}
