import 'package:flutter/material.dart';
import '../../model/stringModel.dart';
import '../../bloc/history.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/myDrawer.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocFactory: () => HistoryBloc(),
        builder: (BuildContext context, HistoryBloc bloc) {
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
                                  onPressed: bloc.onDeleteHistory,
                                )
                              ],
                            );
                          });
                    })
              ],
            ),
            body: StreamBuilder(builder: (BuildContext context, AsyncSnapshot<List<StringModel>> snapshot) {
              return snapshot.data == null
                  ? Center(child: CircularProgressIndicator())
                  : (snapshot.data.isEmpty ? Center(child: Text('No History')) : getBody(snapshot.data));
            }),
          );
        });
  }

  Widget getBody(List<StringModel> models) {
    List<Widget> historyList = [];
    models.forEach((StringModel stringModel) {
      historyList.add(ListTile(title: Text(stringModel.value)));
    });
    return ListView(
      shrinkWrap: true,
      children: historyList,
    );
  }
}
