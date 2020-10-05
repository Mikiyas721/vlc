import 'dart:io';
import 'package:flutter/material.dart';

class MyImageView extends StatelessWidget {
  final File imageFile;
  final int width;
  final int height;

  MyImageView({@required this.imageFile, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Container(
            width: screenWidth,
            height: (height * screenWidth) / width,
            decoration: BoxDecoration(image: DecorationImage(image: FileImage(imageFile), fit: BoxFit.fill)),
          ),
        ));
  }
}
