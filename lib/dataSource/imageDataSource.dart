import 'package:rxdart/rxdart.dart';
import 'package:vlc/core/repository.dart';
import 'package:vlc/model/media.dart';

class ImageRepo extends ListRepo<MediaModel> {
  ImageRepo(BehaviorSubject<List<MediaModel>> subject) : super(subject);
}
