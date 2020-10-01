import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  final void Function() onTrailingTap;
  final void Function() onTap;
  final bool isSelected;

  MyListTile(
      {@required this.leadingIcon,
      @required this.title,
      @required this.onTap,
      this.subTitle,
      this.onTrailingTap,
      this.isSelected});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(
        leadingIcon,
      ),
      title: Text(
        title,
        style: isSelected != null ? TextStyle(fontWeight: FontWeight.bold, fontSize: 16) : null,
      ),
      subtitle: subTitle != null ? Text(subTitle) : null,
      onTap: onTap,
      trailing: onTrailingTap != null
          ? IconButton(
              icon: Icon(Icons.linear_scale),
              onPressed: onTrailingTap,
            )
          : null,
    );
  }
}
