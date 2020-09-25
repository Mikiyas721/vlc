import 'package:flutter/cupertino.dart';
import 'package:vlc/core/jsonModel.dart';
import 'media.dart';

class AlbumModel extends JSONModel {
  final String id;
  final String name;
  final List<MediaModel> imageList;
  final String x = '/storage/emulated/0/DCIM/100MEDIA/IMAG0251.jpg';

  AlbumModel({@required this.id, @required this.name, @required this.imageList}) : super(id);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return null;
  }
}
