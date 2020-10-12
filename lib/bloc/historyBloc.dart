import 'package:get_it/get_it.dart';
import 'package:vlc/model/mediaType.dart';
import '../core/utils/disposable.dart';
import '../dataSource/historyDataSource.dart';
import '../model/media.dart';

class HistoryBloc extends Disposable {
  HistoryRepo _historyRepo = GetIt.instance.get();

  Stream<List<DevicePathModel>> get historyStream =>
      _historyRepo.getStream<List<DevicePathModel>>((value) => value);

  void loadHistory() {
    List<String> history = _historyRepo.getPreference<List>(_historyRepo.preferenceKey);
    List<DevicePathModel> mappedHistory = [];
    if (history != null) {
      history.forEach((String element) {
        print(element);
        final firstSplit = element.split('&');
        final secondSplit = firstSplit[1].split('|');
        mappedHistory.add(DevicePathModel(path: firstSplit[0],dateTime: DateTime.parse(secondSplit[0]),mediaType: getMediaType(secondSplit[1])));
      });
    }
    _historyRepo.updateStream(mappedHistory);
  }

  void onDeleteHistory() {
    _historyRepo.setPreference<List>(_historyRepo.preferenceKey, null);
    _historyRepo.updateStream([]);
  }

  @override
  void dispose() {}
}
