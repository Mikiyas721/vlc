import 'package:flutter/material.dart';
import '../../../ui/customWidget/myTextDisplay.dart';
import '../../../bloc/galleryBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/album.dart';
import '../../../model/mediaType.dart';
import '../../../ui/customWidget/myDrawer.dart';
import '../../customWidget/myDrawer.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBloc>(
      blocFactory: () => ImageBloc(context),
      onInit: (ImageBloc bloc) {
        bloc.loadMedia(MediaType.VIDEO);
        bloc.loadMedia(MediaType.IMAGE);
        bloc.loadMedia(MediaType.COMMON);
      },
      builder: (BuildContext context, ImageBloc bloc) {

        Widget getBody(Stream<List<AlbumModel>> stream) {
          return StreamBuilder(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<AlbumModel>> snapShot) {
                return snapShot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Align(
                        alignment: Alignment.topLeft,
                        child: GridView.builder(
                          itemCount: snapShot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 3),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(
                                            snapShot.data[index].thumbNail),
                                        fit: BoxFit.cover)),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: MyTextDisplay(
                                          text: '${snapShot.data[index].name}',
                                          alignment: Alignment.bottomLeft),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: MyTextDisplay(
                                          text:
                                              '(${snapShot.data[index].assetCount})',
                                          alignment: Alignment.bottomRight),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                bloc.onGalleryPageTap(
                                    snapShot.data[index], bloc);
                              },
                            );
                          },
                          padding: EdgeInsets.all(5),
                        ),
                      );
              });
        }

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
                        bloc.onRefresh(_tabController.index);
                      },
                    )
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.videocam)),
                      Tab(icon: Icon(Icons.image)),
                      Tab(icon: Icon(Icons.all_inclusive)),
                    ],
                  ),
                ),
                body: TabBarView(children: <Widget>[
                  getBody(bloc.videoStream),
                  getBody(bloc.imageStream),
                  getBody(bloc.galleryStream),
                ])));
      },
    );
  }
}
