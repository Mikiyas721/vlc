import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myListTIle.dart';
import '../../../model/media.dart';

class AudioAlbumPage extends StatelessWidget {
  final String title;
  final List<MediaModel> albumAudio;

  const AudioAlbumPage({Key key, this.title, this.albumAudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: getBody(),
      ),
    );
  }

  List<Widget> getBody() {
    List<Widget> elements = [];
    for (MediaModel audio in albumAudio) {
      elements.add(MyListTile(leadingIcon: Icons.audiotrack, title: 'gjk', onTap: () {}));
    }
  }
}
