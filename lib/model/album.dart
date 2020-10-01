import 'dart:io';
import 'package:flutter/material.dart';
import '../core/jsonModel.dart';
import 'media.dart';

class AlbumModel extends JSONModel {
  final String id;
  final String name;
  final int assetCount;
  final File firstAlbumFile;
  final List<MediaModel> mediaList;

  AlbumModel(
      {@required this.id,
      @required this.name,
      @required this.assetCount,
      @required this.mediaList,
      @required this.firstAlbumFile})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return null;
  }
}
