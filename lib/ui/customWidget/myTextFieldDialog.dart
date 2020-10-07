import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MyTextFieldDialog extends StatefulWidget {
  final bool Function(String enteredValue) onOKClicked;

  MyTextFieldDialog({this.onOKClicked});

  @override
  _MyTextFieldDialogState createState() => _MyTextFieldDialogState();
}

class _MyTextFieldDialogState extends State<MyTextFieldDialog> {
  String enteredText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'New Playlist',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        onChanged: (String newValue) {
          setState(() {
            enteredText = newValue;
          });
        },
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        FlatButton(
            onPressed: () {
              if (enteredText == '' || enteredText == null) {
                Toast.show('Invalid Playlist Name', context);
              } else {
                widget.onOKClicked(enteredText)
                    ? Toast.show('Playlist $enteredText Added', context)
                    : Toast.show('Playlist $enteredText Already exists', context);
                Navigator.pop(context);
              }
            },
            child: Text('Ok'))
      ],
    );
  }
}
