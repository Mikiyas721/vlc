import 'package:flutter/material.dart';

class MyImageView extends StatelessWidget {
  final String imagePath;
  final int width;
  final int height;

  MyImageView({@required this.imagePath, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Container(
            width: double.parse(width.toString()),
            height: double.parse(height.toString()),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
          ),
        ));
  }
}
