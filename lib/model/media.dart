import 'package:flutter/cupertino.dart';
import '../core/jsonModel.dart';

class MediaModel extends JSONModel {
  final String mediaId;
  final String mediaPath;

  MediaModel({this.mediaId, @required this.mediaPath}) : super(mediaId);

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}
