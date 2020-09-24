import 'package:rxdart/rxdart.dart';
import 'package:vlc/core/repository.dart';
import 'package:vlc/model/media.dart';

class VideoRepo extends ItemRepo<MediaModel> {
  VideoRepo(BehaviorSubject<MediaModel> subject) : super(subject);
}
