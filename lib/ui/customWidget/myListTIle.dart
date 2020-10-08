import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String path;
  final String title;
  final String subTitle;
  final void Function() onAddAudioTap;
  final void Function() onTap;
  final bool isSelected;

  MyListTile(
      {@required this.leadingIcon,
      @required this.title,
      @required this.onTap,
      this.path,
      this.subTitle,
      this.onAddAudioTap,
      this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
      ),
      title: Text(
        title,
        style: isSelected != null ? TextStyle(fontWeight: FontWeight.bold, fontSize: 15) : null,
      ),
      subtitle: subTitle != null ? Text(subTitle) : null,
      onTap: onTap,
      trailing: onAddAudioTap != null
          ? IconButton(
              icon: Icon(Icons.add),
              onPressed: onAddAudioTap,
            )
          : null,
    );
  }
}
