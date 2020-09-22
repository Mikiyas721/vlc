import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';

class StreamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: Card(
        child: Row(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter a network address with audio file.'),
            ),
            IconButton(icon: Icon(Icons.send), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
