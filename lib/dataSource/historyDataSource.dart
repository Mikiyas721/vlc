import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/media.dart';

class HistoryRepo extends ListRepo<SavedPathModel> {
  String preferenceKey = "HISTORY";

  HistoryRepo(BehaviorSubject<List<SavedPathModel>> subject) : super(subject);

  void addToHistory(String pathToSave) {
    List<String> history = getPreference<List>(preferenceKey);
    history = history ?? [];
    history.add(pathToSave);

    List<SavedPathModel> mappedHistory = [];
    history.forEach((String element) {
      mappedHistory.add(SavedPathModel(path: element));
    });
    setPreference<List>(preferenceKey, history);
    updateStream(mappedHistory);
  }
}
