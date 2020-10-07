import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/stringModel.dart';

class HistoryRepo extends ListRepo<StringModel> {
  String preferenceKey = "HISTORY";

  HistoryRepo(BehaviorSubject<List<StringModel>> subject) : super(subject);


}
