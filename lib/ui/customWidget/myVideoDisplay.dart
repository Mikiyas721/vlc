import 'package:flutter/material.dart';

class MyVideoDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 100,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(''), fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Align(
            child: Text('17s'),
            alignment: Alignment.topLeft,
          ),
          Align(
            child: Text('SD'),
            alignment: Alignment.topRight,
          ),
          Align(
            child: Text('Rich Dad poor dad'),
            alignment: Alignment.bottomLeft,
          ),
          Align(
            child: IconButton(icon: Icon(Icons.linear_scale), onPressed: () {}),
            alignment: Alignment.bottomRight,
          )
        ],
      ),
    );
  }
}
