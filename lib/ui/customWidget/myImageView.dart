import 'dart:io';
import 'package:flutter/material.dart';
import '../../model/media.dart';

class MyImageView extends StatefulWidget {
  final List<MediaModel> family;
  final int currentPictureIndex;
  final File picture;

  MyImageView({this.family, this.currentPictureIndex, this.picture});

  @override
  _MyImageViewState createState() => _MyImageViewState();
}

class _MyImageViewState extends State<MyImageView> {
  MediaModel currentImage;
  int currentIndex;

  @override
  void initState() {
    if (widget.picture == null) {
      currentIndex = widget.currentPictureIndex;
      currentImage = widget.family[currentIndex];
    }
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
          if (widget.picture == null) {
            if (dragUpdateDetails.delta.dx > 0) {
              setState(() {
                if (currentIndex > 0) currentIndex--;
              });
            } else if (dragUpdateDetails.delta.dx < 0) {
              setState(() {
                if (currentIndex < widget.family.length - 1) currentIndex++;
              });
            }
          }
        },
        child: Center(
          child: Container(
            width: screenWidth,
            height: currentImage == null
                ? screenHeight
                : (currentImage.height * screenWidth) / currentImage.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(widget.picture == null ? currentImage.mediaFile : widget.picture),
                    fit: BoxFit.fill)),
          ),
        ),
      ),
    );
  }
}
