import 'package:flutter/material.dart';
import 'package:media/ui/pages/audio/audioAlbumPage.dart';
import 'package:media/ui/pages/videoPlayerPage.dart';
import 'ui/pages/gallery/galleryAlbumPage.dart';
import 'ui/pages/gallery/galleryPage.dart';
import 'injector.dart';
import 'ui/pages/directoriesPage.dart';
import 'ui/pages/gallery/imageViewPage.dart';
import 'ui/pages/historyPage.dart';
import 'ui/pages/playlistsPage.dart';
import 'ui/pages/settingsPage.dart';
import 'ui/pages/audio/streamPage.dart';
import 'ui/pages/audio/audioPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }

  final routes = {
    '/': (BuildContext context) => GalleryPage(),
    '/audioAlbumPage': (BuildContext context) => AudioAlbumPage(),
    '/audioPage': (BuildContext context) => AudioPage(),
    '/streamPage': (BuildContext context) => StreamPage(),
    '/galleryAlbumPage': (BuildContext context) => GalleryAlbumPage(),
    '/directoriesPage': (BuildContext context) => DirectoriesPage(),
    '/historyPage': (BuildContext context) => HistoryPage(),
    '/playlistsPage': (BuildContext context) => PlayListsPage(),
    '/settingsPage': (BuildContext context) => SettingsPage(),
    '/imageViewPage': (BuildContext context) => ImageViewPage(),
    '/videoPlayerPage': (BuildContext context) => VideoPlayerPage(),
  };
}
