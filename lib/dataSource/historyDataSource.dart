import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/media.dart';

class HistoryRepo extends ListRepo<SavedPathModel> {
  String preferenceKey = "HISTORY";

  HistoryRepo(BehaviorSubject<List<SavedPathModel>> subject) : super(subject);


}
