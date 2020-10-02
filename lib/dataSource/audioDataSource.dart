import 'package:rxdart/rxdart.dart';
import '../model/album.dart';
import '../model/url.dart';
import '../core/repository.dart';
import '../model/media.dart';

class RemoteAudioRepo extends ItemRepo<MediaModel> {
  RemoteAudioRepo(BehaviorSubject<MediaModel> subject) : super(subject);
}

class DeviceAudioRepo extends ListRepo<AlbumModel> {
  DeviceAudioRepo(BehaviorSubject<List<AlbumModel>> subject) : super(subject);
}

class CurrentAudioRepo extends ItemRepo<CurrentAudioModel> {
  CurrentAudioRepo(BehaviorSubject<CurrentAudioModel> subject) : super(subject);
}
