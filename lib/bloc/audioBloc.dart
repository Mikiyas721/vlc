import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import '../bloc/galleryBloc.dart';
import '../model/album.dart';
import '../model/url.dart';
import '../dataSource/audioDataSource.dart';
import '../model/media.dart';

class AudioBloc extends MediaBloc {
  final RemoteAudioRepo _remoteAudioRepo = GetIt.instance.get();
  final DeviceAudioRepo _deviceAudioRepo = GetIt.instance.get();
  final PlayingRepo _playingRepo = GetIt.instance.get();
  final AudioPlayer _audioPlayer = GetIt.instance.get();

  Stream<List<AlbumModel>> get deviceAudioStream =>
      _deviceAudioRepo.getStream<List<AlbumModel>>((value) => value);

  Stream<UrlModel> get playingStream => _playingRepo.getStream<UrlModel>((value) => value);

  set url(url) => _playingRepo.updateStream(UrlModel(url: url));

  void onAudioUrlEntered(String newValue) {
    _remoteAudioRepo.updateStream(MediaModel());
  }

  bool onShuffleClicked(List<AlbumModel> audioModels) {
    if (audioModels != null) {
      final selectedAlbum = audioModels[Random().nextInt(audioModels.length - 1)];
      _audioPlayer.stop();
      _audioPlayer.play(selectedAlbum.mediaList[selectedAlbum.mediaList.length - 1].mediaFile.path);
      return true;
    }
    return false;
  }

  void onAlbumRandomPlayClicked(AlbumModel album) {
    int random = Random().nextInt(album.mediaList.length - 1);
    _audioPlayer.stop();
    _audioPlayer.play(album.mediaList[random].mediaFile.path);
  }
  void onAudioTap(String url){
    _audioPlayer.stop();
    _audioPlayer.play(url);
    this.url = url;
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
  }

  String get currentUrl => _remoteAudioRepo.subjectValue.url;

  @override
  void dispose() {}
}
