import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myListTIle.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          MyListTile(
              leadingIcon: Icons.image,
              title: 'Image',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              }),
          MyListTile(
              leadingIcon: Icons.audiotrack,
              title: 'Audio',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/audioPage');
              }),
          MyListTile(
              leadingIcon: Icons.videocam,
              title: 'Video',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/videoPage');
              }),
          MyListTile(
              leadingIcon: Icons.list,
              title: 'Playlists',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/playlistsPage');
              }),
          MyListTile(
              leadingIcon: Icons.folder,
              title: 'Directories',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/directoriesPage');
              }),
          MyListTile(
              leadingIcon: Icons.network_check,
              title: 'Local Network',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/localNetworkPage');
              }),
          MyListTile(
              leadingIcon: Icons.network_wifi,
              title: 'Stream',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/streamPage');
              }),
          MyListTile(
              leadingIcon: Icons.history,
              title: 'History',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/historyPage');
              }),
          Divider(thickness: 1, color: Colors.grey),
          MyListTile(
              leadingIcon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.pushNamed(context, '/settingsPage');
              }),
          MyListTile(
              leadingIcon: Icons.play_circle_filled,
              title: 'About',
              onTap: () {
                Navigator.pushNamed(context, '/aboutPage');
              }),
        ],
      ),
    );
  }
}
