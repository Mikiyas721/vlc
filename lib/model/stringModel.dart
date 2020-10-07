import 'package:vlc/core/jsonModel.dart';

class StringModel extends JSONModel {
  final String value;

  StringModel({this.value}) : super(value);

  @override
  Map<String, dynamic> toMap() {
    return null;
  }
}
