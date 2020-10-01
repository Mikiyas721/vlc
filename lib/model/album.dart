import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vlc/core/jsonModel.dart';
import 'media.dart';

class AlbumModel extends JSONModel {
  final String id;
  final String name;
  final int assetCount;
  final File firstAlbumFile;
  final List<MediaModel> imageList;

  AlbumModel(
      {@required this.id,
      @required this.name,
      @required this.assetCount,
      @required this.imageList,
      @required this.firstAlbumFile})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return null;
  }
}
