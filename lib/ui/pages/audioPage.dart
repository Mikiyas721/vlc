import 'package:flutter/material.dart';
import '../../ui/customWidget/myDrawer.dart';

class AudioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Audio'),
            bottom: TabBar(
                labelPadding: EdgeInsets.only(bottom: 5),
                tabs: [Text('Artists', ), Text('Albums'), Text('Tracks'), Text('Genres')]),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('Artists')),
              Center(child: Text('Albums')),
              Center(child: Text('Tracks')),
              Center(child: Text('Genres'))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.shuffle),
            onPressed: () {},
          ),
        ));
  }
}
