import 'package:flutter/material.dart';
import '../../ui/customWidget/myListTIle.dart';

class MyDrawer extends StatelessWidget {
  final bool isGallerySelected;
  final bool isAudioSelected;
  final bool isPlaylistSelected;
  final bool isDirectoriesSelected;
  final bool isStreamSelected;
  final bool isHistorySelected;

  MyDrawer({
    this.isGallerySelected,
    this.isAudioSelected,
    this.isPlaylistSelected,
    this.isDirectoriesSelected,
    this.isStreamSelected,
    this.isHistorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          MyListTile(
            leadingIcon: Icons.image,
            title: 'Gallery',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            isSelected: isGallerySelected,
          ),
          MyListTile(
            leadingIcon: Icons.audiotrack,
            title: 'Audio',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/audioPage');
            },
            isSelected: isAudioSelected,
          ),
          MyListTile(
            leadingIcon: Icons.list,
            title: 'Playlists',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/playlistsPage');
            },
            isSelected: isPlaylistSelected,
          ),
          MyListTile(
            leadingIcon: Icons.folder,
            title: 'Directories',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/directoriesPage');
            },
            isSelected: isDirectoriesSelected,
          ),
          MyListTile(
            leadingIcon: Icons.network_wifi,
            title: 'Stream',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/streamPage');
            },
            isSelected: isStreamSelected,
          ),
          MyListTile(
            leadingIcon: Icons.history,
            title: 'History',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/historyPage');
            },
            isSelected: isHistorySelected,
          ),
          Divider(thickness: 1, color: Colors.grey),
          MyListTile(
              leadingIcon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.pushNamed(context, '/settingsPage');
              }),
        ],
      ),
    );
  }
}
