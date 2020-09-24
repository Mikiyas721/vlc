import 'package:rxdart/rxdart.dart';
import 'package:vlc/core/repository.dart';
import 'package:vlc/model/video.dart';

class ImageRepo extends ItemRepo<VideoModel> {
  ImageRepo(BehaviorSubject<VideoModel> subject) : super(subject);
}
