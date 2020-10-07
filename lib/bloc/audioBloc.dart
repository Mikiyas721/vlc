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

  Stream<CurrentAudioModel> get onlineStream =>
      _remoteAudioRepo.getStream<CurrentAudioModel>((value) => value);

  Stream<CurrentAudioModel> get playingStream =>
      _currentAudioRepo.getStream<CurrentAudioModel>((value) => value);

  set currentAudio(CurrentAudioModel currentAudioModel) => _currentAudioRepo.updateStream(currentAudioModel);

  void onAudioUrlEntered(String newValue) {
    _remoteAudioRepo
        .updateStream(CurrentAudioModel(path: newValue, isPlaying: false, name: getName(newValue)));
  }

  void onSendUrl() {}

  bool onShuffleClicked(List<AlbumModel> audioModels) {
    if (audioModels != null) {
      MediaModel mediaModel = getRandomTrackFromAlbums(audioModels);
      try {
        _audioPlayer.stop();
      } catch (Exception) {
        debugPrint('Error at onShuffleClicked. No audio file to stop playing');
      }
      _audioPlayer.play(mediaModel.mediaFile.path);
      positionChangeListen(mediaModel);
      onCurrentAudioDone(getRandomTrackFromAlbums(audioModels));
      this.currentAudio =
          CurrentAudioModel(path: mediaModel.mediaFile.path, isPlaying: true, name: mediaModel.getName());
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
    MediaModel mediaModel = album.mediaList[random];
    _audioPlayer.play(mediaModel.mediaFile.path);
    positionChangeListen(mediaModel);
    onCurrentAudioDone(album.mediaList[album.mediaList.length - 1]);
    this.currentAudio =
        CurrentAudioModel(path: mediaModel.mediaFile.path, isPlaying: true, name: mediaModel.getName());
  }

  void onAudioTap(MediaModel mediaModel, List<MediaModel> albumAudio) {
    try {
      _audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAudioTap. No audio file to stop playing');
    }
    _audioPlayer.play(mediaModel.mediaFile.path);
    positionChangeListen(mediaModel);
    onCurrentAudioDone(mediaModel);
    this.currentAudio =
        CurrentAudioModel(path: mediaModel.mediaFile.path, isPlaying: true, name: mediaModel.getName());
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
  }

  MediaModel getRandomTrackFromAlbums(List<AlbumModel> audioModels) {
    final selectedAlbum = audioModels[Random().nextInt(audioModels.length - 1)];
    return selectedAlbum.mediaList[selectedAlbum.mediaList.length - 1];
  }

  void positionChangeListen(MediaModel mediaModel) {
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) async{
      this.currentAudio = CurrentAudioModel(
          path: mediaModel.mediaFile.path,
          isPlaying: true,
          // Not for fast forward and fast rewind
          currentAudioPosition: await _audioPlayer.getCurrentPosition(),
          audioDuration: await _audioPlayer.getDuration(),
          name: mediaModel.getName());
    });
  }

  void onCurrentAudioDone(MediaModel mediaModel) {
    // TODO accept a list instead
    _audioPlayer.onPlayerCompletion.listen((data) async {
      _audioPlayer.play(mediaModel.mediaFile.path);
      this.currentAudio = CurrentAudioModel(
          path: mediaModel.mediaFile.path,
          isPlaying: true,
          currentAudioPosition: await _audioPlayer.getCurrentPosition(),
          audioDuration: await _audioPlayer.getDuration(),
          name: mediaModel.getName());
    });
  }

  static String getName(String path) {
    List<String> split = path.split('/');
    return split.elementAt(split.length - 1);
  }
  void onAddAudioTap(){
  }

  @override
  void dispose() {}
}
