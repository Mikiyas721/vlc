import '../core/jsonModel.dart';

class CurrentAudioModel extends JSONModel {
  final bool isPlaying;
  final String url;

  CurrentAudioModel({this.url, this.isPlaying}) : super(url);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
