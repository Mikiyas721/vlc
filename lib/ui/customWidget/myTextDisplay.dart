import 'package:flutter/material.dart';

class MyTextDisplay extends StatelessWidget {
  final Alignment alignment;
  final String text;

  MyTextDisplay({@required this.text, @required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black38),
          padding: EdgeInsets.all(5),
          child: Text(
            text,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.white),
          )),
    );
  }
}
