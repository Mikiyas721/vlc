import 'package:flutter/material.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/album.dart';
import '../../../ui/customWidget/audioAlbum.dart';
import '../../customWidget/myDrawer.dart';

class AudioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocFactory: () => AudioBloc(),
      builder: (BuildContext context, AudioBloc bloc) {
        bloc.loadDeviceAudio();
        return Scaffold(
          drawer: MyDrawer(isAudioSelected: true),
          appBar: AppBar(title: Text('Audio')),
          body: StreamBuilder(
              stream: bloc.deviceAudioStream,
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                return snapShot.data == null
                    ? Center(child: CircularProgressIndicator())
                    : Align(
                        alignment: Alignment.topLeft,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: getGridElements(context, snapShot.data),
                        ),
                      );
              }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.shuffle),
            onPressed: () {},
          ),
        );
      },
    );
  }

  List<Widget> getGridElements(BuildContext context, List<AlbumModel> audioModels) {
    List<Widget> widgets = [];
    for (AlbumModel album in audioModels) {
      widgets.add(AudioAlbum(albumName: album.name, onPlayPressed: () {}, onAlbumTap: () {}));
    }
    return widgets;
  }
}
