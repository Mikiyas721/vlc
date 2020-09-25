import 'package:rxdart/rxdart.dart';
import 'package:vlc/model/album.dart';
import '../core/repository.dart';
import '../model/media.dart';

class ImageRepo extends ListRepo<MediaModel> {
  ImageRepo(BehaviorSubject<List<MediaModel>> subject) : super(subject);
}
