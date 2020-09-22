import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';

class LocalNetworkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Local Network'),
      ),
      body: Center(child: Text('Local Network')),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
    );
  }
}
