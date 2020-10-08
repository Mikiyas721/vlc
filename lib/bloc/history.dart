import 'package:get_it/get_it.dart';
import '../core/utils/disposable.dart';
import '../dataSource/historyDataSource.dart';
import '../model/media.dart';

class HistoryBloc extends Disposable {
  HistoryRepo _historyRepo = GetIt.instance.get();

  Stream<List<SavedPathModel>> get historyStream => _historyRepo.getStream<List<SavedPathModel>>((value) => value);

  void onDeleteHistory() {
    _historyRepo.setPreference<List>(_historyRepo.preferenceKey, null);
    _historyRepo.updateStream([]);
  }

  @override
  void dispose() {}
}
