import 'package:flutter/material.dart';

class MyPlaylistSelectionDialog extends StatefulWidget {
  final List<String> options;
  final void Function(List<CheckValue> checkValue) onOKClicked;

  MyPlaylistSelectionDialog({this.options, this.onOKClicked});

  @override
  _MyPlaylistSelectionDialogState createState() => _MyPlaylistSelectionDialogState();
}

class _MyPlaylistSelectionDialogState extends State<MyPlaylistSelectionDialog> {
  List<CheckValue> checkValues = [];

  @override
  void initState() {
    widget.options.forEach((String option) {
      checkValues.add(CheckValue(title: option, value: false));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select playlists to add to'),
      content: getBody(),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        FlatButton(
          onPressed: () {
            widget.onOKClicked(checkValues);
            Navigator.pop(context);
          },
          child: Text('Ok'),
        )
      ],
    );
  }

  Widget getBody() {
    List<Widget> widgets = [];
    checkValues.forEach((CheckValue option) {
      widgets.add(CheckboxListTile(
          title: Text(option.title),
          value: option.value,
          onChanged: (bool newValue) {
            setState(() {
              option.value = !option.value;
            });
          }));
    });
    return ListView(
      children: widgets,
      shrinkWrap: true,
    );
  }
}

class CheckValue {
  String title;
  bool value;

  CheckValue({this.title, this.value});
}
