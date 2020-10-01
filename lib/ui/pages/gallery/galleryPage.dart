import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vlc/bloc/galleryBloc.dart';
import 'package:vlc/bloc/provider/provider.dart';
import 'package:vlc/model/album.dart';
import 'package:vlc/model/mediaType.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';
import 'package:vlc/ui/pages/gallery/galleryAlbumPage.dart';
import '../../../bloc/galleryBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../customWidget/myDrawer.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBloc>(
      blocFactory: () => ImageBloc(),
      builder: (BuildContext context, ImageBloc bloc) {
        bloc.loadMedia(MediaType.COMMON);
        bloc.loadMedia(MediaType.IMAGE);
        bloc.loadMedia(MediaType.VIDEO);
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              drawer: MyDrawer(isGallerySelected: true),
              appBar: AppBar(
                title: Text('Albums'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      await bloc.loadMedia(MediaType.COMMON);
                      await bloc.loadMedia(MediaType.IMAGE);
                      await bloc.loadMedia(
                          MediaType.VIDEO); // TODO Check if its is possible to know the active tab
                    },
                  )
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.all_inclusive)),
                    Tab(icon: Icon(Icons.image)),
                    Tab(icon: Icon(Icons.videocam))
                  ],
                ),
              ),
              body: TabBarView(children: <Widget>[
                getBody(bloc.galleryStream),
                getBody(bloc.imageStream),
                getBody(bloc.videoStream),
              ]),
            ));
      },
    );
  }

  getBody(Stream<List<AlbumModel>> stream) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<List<AlbumModel>> snapShot) {
          return snapShot.data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: GridView.count(
                    crossAxisCount: 1,
                    children: getAlbums(context, snapShot.data),
                    padding: EdgeInsets.all(5),
                  ),
                );
        });
  }
}

List<Widget> getAlbums(BuildContext context, List<AlbumModel> albumModels) {
  List<Widget> albums = [];
  for (AlbumModel album in albumModels) {
    albums.add(GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 3),
        decoration:
            BoxDecoration(image: DecorationImage(image: FileImage(album.firstAlbumFile), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  album.name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '(${album.assetCount})',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return GalleryAlbumPage(
            title: album.name,
            mediaModels: album.mediaList,
          );
        }));
      },
    ));
  }

  return albums;
}
