import 'package:flutter/material.dart';

class MyImageView extends StatelessWidget {
  final String imagePath;

  MyImageView({@required this.imagePath});

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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
          ),
        ));
  }
}
