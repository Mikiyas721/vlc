import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Center(child: Text('Videos')),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.play_arrow), onPressed: () {}),
    );
  }
}
