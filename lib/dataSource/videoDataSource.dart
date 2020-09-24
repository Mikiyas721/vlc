import 'package:rxdart/rxdart.dart';
import 'package:vlc/core/repository.dart';
import 'package:vlc/model/video.dart';

class VideoRepo extends ItemRepo<VideoModel> {
  VideoRepo(BehaviorSubject<VideoModel> subject) : super(subject);
}
