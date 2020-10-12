import 'package:flutter/material.dart';
import '../../model/media.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

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
  double scale = 1;

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
        onScaleUpdate: (ScaleUpdateDetails scaleUpdateDetails) {
          if (scaleUpdateDetails.focalPoint.dx > 0) {
            setState(() {
              if (currentIndex < widget.family.length - 1) {
                currentIndex++;
                currentImage = widget.family[currentIndex];
              }
            });
          } else {
            if (currentIndex > 0) {
              currentIndex--;
              currentImage = widget.family[currentIndex];
            }
          }
          setState(() {
            scale = scaleUpdateDetails.scale;
          });
        },
        onDoubleTap: () {
          setState(() {
            if (scale == 1)
              scale = 2;
            else
              scale = 1;
          });
        },
        child: Center(
          child: Transform(
            transform: Matrix4.diagonal3(Vector3.all(scale)),
            alignment: FractionalOffset.center,
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
      ),
    );
  }
}
