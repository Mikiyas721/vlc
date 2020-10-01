import 'package:rxdart/rxdart.dart';
import 'package:vlc/model/album.dart';
import '../core/repository.dart';
import '../model/media.dart';

class GalleryRepo extends ListRepo<AlbumModel> {
  GalleryRepo(BehaviorSubject<List<AlbumModel>> subject) : super(subject);
}
