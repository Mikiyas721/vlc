import 'package:flutter/material.dart';
import 'package:vlc/ui/pages/aboutPage.dart';
import 'package:vlc/ui/pages/directoriesPage.dart';
import 'package:vlc/ui/pages/historyPage.dart';
import 'package:vlc/ui/pages/localNetworkPage.dart';
import 'package:vlc/ui/pages/playlistsPage.dart';
import 'package:vlc/ui/pages/settingsPage.dart';
import 'package:vlc/ui/pages/streamPage.dart';
import 'package:vlc/ui/pages/videoPage.dart';
import 'ui/pages/audioPage.dart';

void main() => runApp(MyApp());

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
    '/aboutPage': (BuildContext context) => AboutPage(),
    '/audioPage': (BuildContext context) => AudioPage(),
    '/directoriesPage': (BuildContext context) => DirectoriesPage(),
    '/historyPage': (BuildContext context) => HistoryPage(),
    '/localNetworkPage': (BuildContext context) => LocalNetworkPage(),
    '/playlistsPage': (BuildContext context) => PlayListsPage(),
    '/settingsPage': (BuildContext context) => SettingsPage(),
    '/streamPage': (BuildContext context) => StreamPage(),
    '/': (BuildContext context) => VideoPage()
  };
}
