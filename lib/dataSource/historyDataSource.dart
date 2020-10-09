import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/media.dart';

class HistoryRepo extends ListRepo<DevicePathModel> {
  String preferenceKey = "HISTORY";

  HistoryRepo(BehaviorSubject<List<DevicePathModel>> subject) : super(subject);

  void addToHistory(String pathToSave) {
    List<String> history = getPreference<List>(preferenceKey);
    history = history ?? [];
    history.add(pathToSave);

    List<DevicePathModel> mappedHistory = [];
    history.forEach((String element) {
      mappedHistory.add(DevicePathModel(path: element));
    });
    setPreference<List>(preferenceKey, history);
    updateStream(mappedHistory);
  }
}
