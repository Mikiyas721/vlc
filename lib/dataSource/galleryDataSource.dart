import 'package:rxdart/rxdart.dart';
import '../model/album.dart';
import '../core/repository.dart';

class GalleryRepo extends ListRepo<AlbumModel> {
  GalleryRepo(BehaviorSubject<List<AlbumModel>> subject) : super(subject);
}

class VideoRepo extends ListRepo<AlbumModel> {
  VideoRepo(BehaviorSubject<List<AlbumModel>> subject) : super(subject);
}

class ImageRepo extends ListRepo<AlbumModel> {
  ImageRepo(BehaviorSubject<List<AlbumModel>> subject) : super(subject);
}
