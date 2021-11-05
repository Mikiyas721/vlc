import 'package:flutter/material.dart';
import '../../model/mediaType.dart';
import '../../ui/customWidget/myListTIle.dart';
import '../../model/media.dart';
import '../../bloc/historyBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/myDrawer.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => HistoryBloc(context),
        onInit: (HistoryBloc bloc) {
          bloc.loadHistory();
        },
        builder: (BuildContext context, HistoryBloc bloc) {
          return Scaffold(
            drawer: MyDrawer(isHistorySelected: true),
            appBar: AppBar(
              title: Text('History'),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete), onPressed: bloc.onDeleteHistory)
              ],
            ),
            body: StreamBuilder(
                stream: bloc.historyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<DevicePathModel>> snapshot) {
                  return snapshot.data == null
                      ? Center(child: CircularProgressIndicator())
                      : (snapshot.data.isEmpty
                          ? Center(child: Text('No History'))
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MyListTile(
                                  leadingIcon: snapshot.data[index].mediaType ==
                                          MediaType.VIDEO
                                      ? Icons.videocam
                                      : Icons.music_note,
                                  title: snapshot.data[index].getName(),
                                  onTap: () {},
                                  subTitle: snapshot.data[index].dateTime
                                      .toString()
                                      .split('.')[0],
                                );
                              },
                              shrinkWrap: true,
                            ));
                }),
          );
        });
  }
}
