import 'package:flutter/material.dart';
import 'package:vlc/model/mediaType.dart';
import 'package:vlc/ui/customWidget/myListTIle.dart';
import '../../model/media.dart';
import '../../bloc/historyBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/myDrawer.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => HistoryBloc(),
        builder: (BuildContext context, HistoryBloc bloc) {
          bloc.loadHistory();
          return Scaffold(
            drawer: MyDrawer(isHistorySelected: true),
            appBar: AppBar(
              title: Text('History'),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Are you sure you want to delete your history'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    bloc.onDeleteHistory();
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    })
              ],
            ),
            body: StreamBuilder(
                stream: bloc.historyStream,
                builder: (BuildContext context, AsyncSnapshot<List<DevicePathModel>> snapshot) {
                  return snapshot.data == null
                      ? Center(child: CircularProgressIndicator())
                      : (snapshot.data.isEmpty ? Center(child: Text('No History')) : getBody(snapshot.data));
                }),
          );
        });
  }

  Widget getBody(List<DevicePathModel> models) {
    List<Widget> historyList = [];
    models.forEach((DevicePathModel stringModel) {
      historyList.add(MyListTile(
        leadingIcon: stringModel.mediaType == MediaType.VIDEO ? Icons.videocam : Icons.music_note,
        title: stringModel.getName(),
        onTap: () {},
        subTitle: stringModel.dateTime.toString().split('.')[0],
      ));
      //TODO add DateTime and media type
    });
    return ListView(
      shrinkWrap: true,
      children: historyList,
    );
  }
}
