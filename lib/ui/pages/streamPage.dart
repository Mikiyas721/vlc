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
            margin: EdgeInsets.all(0),
            child: Padding(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Enter a network address with audio file.'),
                      )),
                  IconButton(icon: Icon(Icons.send), onPressed: () {})
                ],
              ),
              padding: EdgeInsets.all(10),
            )));
  }
}
