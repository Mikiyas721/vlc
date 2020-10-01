import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vlc/bloc/galleryBloc.dart';
import 'package:vlc/model/album.dart';
import '../dataSource/audioDataSource.dart';
import '../model/media.dart';

class AudioBloc extends MediaBloc {
  final RemoteAudioRepo _remoteAudioRepo = GetIt.instance.get();
  final DeviceAudioRepo _deviceAudioRepo = GetIt.instance.get();

  Stream<List<AlbumModel>> get deviceAudioStream =>
      _deviceAudioRepo.getStream<List<AlbumModel>>((value) => value);

  onAudioUrlEntered(String newValue) {
    _remoteAudioRepo.updateStream(MediaModel());
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
  }

  String get currentUrl => _remoteAudioRepo.subjectValue.path;

  @override
  void dispose() {}
}
