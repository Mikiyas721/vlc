import 'package:flutter/material.dart';
import 'ui/pages/gallery/galleryPage.dart';
import 'injector.dart';
import 'ui/pages/directoriesPage.dart';
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
      title: 'Vlc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }

  final routes = {
    '/audioPage': (BuildContext context) => AudioPage(),
    '/directoriesPage': (BuildContext context) => DirectoriesPage(),
    '/historyPage': (BuildContext context) => HistoryPage(),
    '/': (BuildContext context) => GalleryPage(),
    '/playlistsPage': (BuildContext context) => PlayListsPage(),
    '/settingsPage': (BuildContext context) => SettingsPage(),
    '/streamPage': (BuildContext context) => StreamPage(),
  };
}
