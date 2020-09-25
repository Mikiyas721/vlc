import 'package:flutter/material.dart';
import 'injector.dart';
import './ui/pages/aboutPage.dart';
import './ui/pages/directoriesPage.dart';
import './ui/pages/historyPage.dart';
import 'ui/pages/imagePage.dart';
import './ui/pages/localNetworkPage.dart';
import './ui/pages/playlistsPage.dart';
import './ui/pages/settingsPage.dart';
import './ui/pages/streamPage.dart';
import './ui/pages/videoPage.dart';
import './ui/pages/audioPage.dart';

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
    '/aboutPage': (BuildContext context) => AboutPage(),
    '/': (BuildContext context) => AudioPage(),
    '/directoriesPage': (BuildContext context) => DirectoriesPage(),
    '/historyPage': (BuildContext context) => HistoryPage(),
    '/imagePage': (BuildContext context) => ImagePage(),
    '/localNetworkPage': (BuildContext context) => LocalNetworkPage(),
    '/playlistsPage': (BuildContext context) => PlayListsPage(),
    '/settingsPage': (BuildContext context) => SettingsPage(),
    '/streamPage': (BuildContext context) => StreamPage(),
    '/videoPage': (BuildContext context) => VideoPage()
  };
}
