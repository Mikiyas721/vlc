import 'package:flutter/material.dart';
import '../../bloc/playlistBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/stringModel.dart';
import '../../ui/customWidget/audioAlbum.dart';
import '../../ui/customWidget/myTextFieldDialog.dart';
import '../../ui/customWidget/myDrawer.dart';

class PlayListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocFactory: () => PlayListBloc(),
      builder: (BuildContext context, PlayListBloc bloc) {
        bloc.loadPlayLists();
        return Scaffold(
          drawer: MyDrawer(isPlaylistSelected: true),
          appBar: AppBar(
            title: Text('Playlists'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyTextFieldDialog(
                            onOKClicked: bloc.onOkClicked,
                          );
                        });
                  })
            ],
          ),
          body: StreamBuilder(
            stream: bloc.playlistStream,
            builder: (BuildContext context, AsyncSnapshot<List<StringModel>> snapshot) {
              bloc.loadPlayLists();
              return snapshot.data == null
                  ? Center(child: CircularProgressIndicator())
                  : (snapshot.data.isEmpty
                      ? Center(
                          child: Text('No Playlist found'),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          children: getBody(snapshot.data),
                        ));
            },
          ),
        );
      },
    );
  }

  List<Widget> getBody(List<StringModel> list) {
    List<Widget> body = [];
    list.forEach((element) {
      body.add(AudioAlbum(albumName: element.value, onPlayPressed: () {}, onAlbumTap: () {}));
    });
    return body;
  }
}
