import 'package:rxdart/rxdart.dart';
import 'package:vlc/core/repository.dart';
import 'package:vlc/model/video.dart';

class VideoRepo extends ListRepo<VideoModel> {
  VideoRepo(BehaviorSubject<List<VideoModel>> subject) : super(subject);
}
