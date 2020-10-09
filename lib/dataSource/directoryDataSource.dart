import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/media.dart';

class DirectoryRepo extends ListRepo<DevicePathModel> {
  DirectoryRepo(BehaviorSubject<List<DevicePathModel>> subject) : super(subject);
}
