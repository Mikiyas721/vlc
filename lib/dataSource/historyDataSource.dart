import 'package:rxdart/rxdart.dart';
import '../model/mediaType.dart';
import '../core/repository.dart';
import '../model/media.dart';

class HistoryRepo extends ListRepo<DevicePathModel> {
  String preferenceKey = "HISTORY";

  HistoryRepo(BehaviorSubject<List<DevicePathModel>> subject) : super(subject);

  void addToHistory(String pathToSave,MediaType mediaType) {
    List<String> history = getPreference<List>(preferenceKey);
    history = history ?? [];
    history.add('$pathToSave&${DateTime.now().toString()}|${mediaType.toString()}');

    List<DevicePathModel> mappedHistory = [];
    history.forEach((String element) {
      mappedHistory.add(DevicePathModel(path: element, dateTime: DateTime.now(), mediaType: mediaType));
    });
    setPreference<List>(preferenceKey, history);
    updateStream(mappedHistory);
  }
}
