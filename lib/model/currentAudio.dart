import '../core/jsonModel.dart';
import 'media.dart';

class CurrentAudioModel extends JSONModel {
  final bool isPlaying;
  final String path;
  final String name;
  final int currentAudioPosition;
  final int audioDuration;
  final List<PathModel> family;
  final int currentAudioIndex;
  final bool isStopped;

  CurrentAudioModel(
      {this.isPlaying,
      this.name,
      this.currentAudioPosition = 0,
      this.audioDuration = 1,
      this.family,
      this.currentAudioIndex,
      this.path,
      this.isStopped = true})
      : super(path);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
