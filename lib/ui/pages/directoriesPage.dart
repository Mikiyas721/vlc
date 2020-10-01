import 'package:flutter/material.dart';
import '../../ui/customWidget/myDrawer.dart';

class DirectoriesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(isDirectoriesSelected: true),
      appBar: AppBar(
        title: Text('Directories'),
      ),
      body: Center(child: Text('Directories')),
    );
  }

}