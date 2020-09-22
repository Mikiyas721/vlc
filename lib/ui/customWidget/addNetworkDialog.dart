import 'package:flutter/material.dart';

class AddNetworkDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: <Widget>[],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        FlatButton(onPressed: () {}, child: Text('Ok'))
      ],
    );
  }
}
