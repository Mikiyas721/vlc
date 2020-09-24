import 'package:flutter/material.dart';
import '../../ui/customWidget/myDrawer.dart';

class PlayListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Playlists'),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: Center(child: Text('Playlists')),
    );
  }
}
