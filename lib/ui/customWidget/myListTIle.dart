import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final void Function() onTap;

  MyListTile({this.leadingIcon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
