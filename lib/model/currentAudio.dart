import '../core/jsonModel.dart';

class CurrentAudioModel extends JSONModel {
  final bool isPlaying;
  final String path;
  final int currentAudioPosition;
  final int audioDuration;

  CurrentAudioModel({this.path, this.isPlaying, this.currentAudioPosition = 0, this.audioDuration = 1})
      : super(path);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
