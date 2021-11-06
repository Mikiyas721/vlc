import 'package:flutter/material.dart';
import '../../../model/media.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class ImageViewPage extends StatefulWidget {
  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  List<PathModel> family;
  int currentIndex;
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    currentIndex = map['currentPictureIndex'];
    family = map['family'];
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
              if (currentIndex < family.length - 1) {
                currentIndex++;
              }
            });
          } else {
            if (currentIndex > 0) {
              currentIndex--;
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
              height: family[currentIndex].runtimeType == MediaModel
                  ? ((family[currentIndex] as MediaModel).height *
                          screenWidth) /
                      (family[currentIndex] as MediaModel).width
                  : screenHeight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(family[currentIndex].mediaFile),
                      fit: BoxFit.fill)),
            ),
          ),
        ),
      ),
    );
  }
}
