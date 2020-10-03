import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import '../bloc/galleryBloc.dart';
import '../model/album.dart';
import '../model/currentAudio.dart';
import '../dataSource/audioDataSource.dart';
import '../model/media.dart';

class AudioBloc extends MediaBloc {
  final RemoteAudioRepo _remoteAudioRepo = GetIt.instance.get();
  final DeviceAudioRepo _deviceAudioRepo = GetIt.instance.get();
  final CurrentAudioRepo _currentAudioRepo = GetIt.instance.get();
  final AudioPlayer _audioPlayer = GetIt.instance.get();

  Stream<List<AlbumModel>> get deviceAudioStream =>
      _deviceAudioRepo.getStream<List<AlbumModel>>((value) => value);

  Stream<CurrentAudioModel> get playingStream =>
      _currentAudioRepo.getStream<CurrentAudioModel>((value) => value);

  set currentAudio(CurrentAudioModel currentAudioModel) => _currentAudioRepo.updateStream(currentAudioModel);

  void onAudioUrlEntered(String newValue) {
    _remoteAudioRepo.updateStream(MediaModel());
  }

  bool onShuffleClicked(List<AlbumModel> audioModels) {
    if (audioModels != null) {
      final selectedAlbum = audioModels[Random().nextInt(audioModels.length - 1)];
      _audioPlayer.stop();
      String path = selectedAlbum.mediaList[selectedAlbum.mediaList.length - 1].mediaFile.path;
      _audioPlayer.play(path);
      _currentAudioRepo.updateStream(CurrentAudioModel(url: path, isPlaying: true));
      return true;
    }
    return false;
  }

  void onAlbumRandomPlayClicked(AlbumModel album) {
    int random = Random().nextInt(album.mediaList.length - 1);
    _audioPlayer.stop();
    String url = album.mediaList[random].mediaFile.path;
    _audioPlayer.play(url);
    this.currentAudio = CurrentAudioModel(url: url, isPlaying: true);
  }

  void onAudioTap(CurrentAudioModel audioModel) {
    _audioPlayer.stop();
    _audioPlayer.play(audioModel.url);
    this.currentAudio = audioModel;
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
  }

  String get currentUrl => _remoteAudioRepo.subjectValue.url;

  @override
  void dispose() {}
}
