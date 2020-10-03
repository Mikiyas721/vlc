import 'package:flutter/cupertino.dart';

import '../core/jsonModel.dart';

class CurrentAudioModel extends JSONModel {
  final bool isPlaying;
  final String path;
  final String name;
  final int currentAudioPosition;
  final int audioDuration;

  CurrentAudioModel({
    @required this.path,
    @required this.isPlaying,
    @required this.name,
    this.currentAudioPosition = 0,
    this.audioDuration = 1,
  }) : super(path);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
