import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vlc/bloc/galleryBloc.dart';
import 'package:vlc/bloc/provider/provider.dart';
import 'package:vlc/model/album.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';
import 'package:vlc/ui/customWidget/myImageView.dart';
import 'package:vlc/ui/pages/albumPage.dart';
import '../customWidget/myImageView.dart';
import '../../bloc/galleryBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/media.dart';
import '../customWidget/myDrawer.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBloc>(
      blocFactory: () => ImageBloc(),
      builder: (BuildContext context, ImageBloc bloc) {
        bloc.loadImage();
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Albums'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: bloc.loadImage,
              )
            ],
          ),
          body: StreamBuilder(
              stream: bloc.galleryStream,
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
              }),
        );
      },
    );
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
          return AlbumPage(
            title: album.name,
            mediaModels: album.imageList,
          );
        }));
      },
    ));
  }

  return albums;
}

