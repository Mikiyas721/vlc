import 'package:vlc/core/jsonModel.dart';

class VideoModel extends JSONModel {
  VideoModel(String value) : super(value);

  @override
  Map<String, dynamic> toMap() {
    return {'value': this.value};
  }
}
