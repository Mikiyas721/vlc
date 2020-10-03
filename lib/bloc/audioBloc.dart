import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
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
      String path = getRandomTrackFromAlbums(audioModels);
      try {
        _audioPlayer.stop();
      } catch (Exception) {
        debugPrint('Error at onShuffleClicked. No audio file to stop playing');
      }
      _audioPlayer.play(path);
      positionChangeListen(path);
      onCurrentAudioDone(getRandomTrackFromAlbums(audioModels));
      return true;
    }
    return false;
  }

  void onAlbumRandomPlayClicked(AlbumModel album) {
    int random = Random().nextInt(album.mediaList.length - 1);
    try {
      _audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAlbumRandomPlayClicked. No audio file to stop playing');
    }
    String path = album.mediaList[random].mediaFile.path;
    _audioPlayer.play(path);
    positionChangeListen(path);
    onCurrentAudioDone(album.mediaList[album.mediaList.length - 1].mediaFile.path);
    this.currentAudio = CurrentAudioModel(path: path, isPlaying: true);
  }

  void onAudioTap(CurrentAudioModel audioModel, List<MediaModel> albumAudio) {
    try {
      _audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAudioTap. No audio file to stop playing');
    }
    _audioPlayer.play(audioModel.path);
    positionChangeListen(audioModel.path);
    onCurrentAudioDone(albumAudio[albumAudio.length - 1].mediaFile.path);
    this.currentAudio = audioModel;
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
  }

  String getRandomTrackFromAlbums(List<AlbumModel> audioModels) {
    final selectedAlbum = audioModels[Random().nextInt(audioModels.length - 1)];
    String path = selectedAlbum.mediaList[selectedAlbum.mediaList.length - 1].mediaFile.path;
    return path;
  }

  Future<void> positionChangeListen(String path) async {
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) async {
      _currentAudioRepo.updateStream(CurrentAudioModel(
          path: path,
          isPlaying: true,
          currentAudioPosition: await _audioPlayer.getCurrentPosition(),
          audioDuration: await _audioPlayer.getDuration()));
    });
  }

  Future<void> onCurrentAudioDone(String path) async {
    _audioPlayer.onPlayerCompletion.listen((data) async {
      _audioPlayer.play(path); // TODO Handle Error
      _currentAudioRepo.updateStream(CurrentAudioModel(
          path: path,
          isPlaying: true,
          currentAudioPosition: await _audioPlayer.getCurrentPosition(),
          audioDuration: await _audioPlayer.getDuration()));
    });
  }

  String get currentUrl => _remoteAudioRepo.subjectValue.url;

  @override
  void dispose() {}
}
