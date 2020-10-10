import 'dart:io';
import 'package:flutter/material.dart';
import '../../model/media.dart';

class MyImageView extends StatefulWidget {
  final List<PathModel> family;
  final int currentPictureIndex;

  MyImageView({this.family, this.currentPictureIndex});

  @override
  _MyImageViewState createState() => _MyImageViewState();
}

class _MyImageViewState extends State<MyImageView> {
  var currentImage;
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.currentPictureIndex;
    currentImage = widget.family[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails dragUpdateDetails) {
          if (dragUpdateDetails.delta.dx > 0) {
            setState(() {
              if (currentIndex > 0) currentIndex--;
            });
          } else if (dragUpdateDetails.delta.dx < 0) {
            setState(() {
              if (currentIndex < widget.family.length - 1) currentIndex++;
            });
          }
        },
        child: Center(
          child: Container(
            width: screenWidth,
            height: currentImage.runtimeType == MediaModel
                ? (currentImage.height * screenWidth) / currentImage.width
                : screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(currentImage.mediaFile), fit: BoxFit.fill)),
          ),
        ),
      ),
    );
  }
}
