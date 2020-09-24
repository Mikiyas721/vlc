import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/media.dart';

class VideoRepo extends ItemRepo<MediaModel> {
  VideoRepo(BehaviorSubject<MediaModel> subject) : super(subject);
}
