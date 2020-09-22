import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';

class StreamPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: Center(child: Text('Stream')),
    );
  }

}