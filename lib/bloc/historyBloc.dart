import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../model/mediaType.dart';
import '../core/utils/disposable.dart';
import '../dataSource/historyDataSource.dart';
import '../model/media.dart';

class HistoryBloc extends MyDisposable {
  final BuildContext context;
  HistoryRepo _historyRepo = GetIt.instance.get();

  HistoryBloc(this.context);

  Stream<List<DevicePathModel>> get historyStream =>
      _historyRepo.getStream<List<DevicePathModel>>((value) => value);

  void loadHistory() {
    List<String> history = _historyRepo.getPreference<List>(_historyRepo.preferenceKey);
    List<DevicePathModel> mappedHistory = [];
    if (history != null) {
      history.forEach((String element) {
        final firstSplit = element.split('&');
        final secondSplit = firstSplit[1].split('|');
        mappedHistory.add(DevicePathModel(path: firstSplit[0],dateTime: DateTime.parse(secondSplit[0]),mediaType: getMediaType(secondSplit[1])));
      });
    }
    _historyRepo.updateStream(mappedHistory);
  }

  Future<void> onDeleteHistory() async{
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
                  _historyRepo.setPreference<List>(_historyRepo.preferenceKey, null);
                  _historyRepo.updateStream([]);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _historyRepo.dataStream.close();
  }
}
