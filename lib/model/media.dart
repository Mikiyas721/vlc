import 'package:flutter/cupertino.dart';
import 'package:vlc/core/jsonModel.dart';

class MediaModel extends JSONModel {
  final String mediaId;
  final String mediaPath;

  MediaModel({@required this.mediaId, @required this.mediaPath}) : super(mediaId);

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}
