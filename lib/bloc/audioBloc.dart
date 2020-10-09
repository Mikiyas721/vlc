import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import '../dataSource/historyDataSource.dart';
import '../dataSource/playlistDataSource.dart';
import '../ui/customWidget/myPlaylistSelectionDialog.dart';
import '../bloc/galleryBloc.dart';
import '../model/album.dart';
import '../model/currentAudio.dart';
import '../dataSource/audioDataSource.dart';
import '../model/media.dart';

abstract class AudioPlayersBloc extends MediaBloc {
  @protected
  final AudioPlayer audioPlayer = GetIt.instance.get();
  @protected
  final CurrentAudioRepo currentAudioRepo = GetIt.instance.get();
  @protected
  final PlaylistRepo playlistRepo = GetIt.instance.get();
  @protected
  final HistoryRepo historyRepo = GetIt.instance.get();

  set currentAudio(CurrentAudioModel currentAudioModel) => currentAudioRepo.updateStream(currentAudioModel);

  Stream<CurrentAudioModel> get playingStream =>
      currentAudioRepo.getStream<CurrentAudioModel>((value) => value);

  List<String> get getPlaylists => playlistRepo.getPlayLists;

  void positionChangeListen(PathModel pathModel) {
    audioPlayer.onAudioPositionChanged.listen((Duration duration) async {
      this.currentAudio = CurrentAudioModel(
          path: pathModel.path,
          isPlaying: true,
          // Not for fast forward and fast rewind
          currentAudioPosition: await audioPlayer.getCurrentPosition(),
          audioDuration: await audioPlayer.getDuration(),
          name: pathModel.getName());
    });
  }

  void onCurrentAudioDone(PathModel pathModel) {
    // TODO accept a list instead
    audioPlayer.onPlayerCompletion.listen((data) async {
      audioPlayer.play(pathModel.path);
      historyRepo.addToHistory(pathModel.path);
      this.currentAudio = CurrentAudioModel(
          path: pathModel.path,
          isPlaying: true,
          currentAudioPosition: await audioPlayer.getCurrentPosition(),
          audioDuration: await audioPlayer.getDuration(),
          name: pathModel.getName());
    });
  }
}

class AudioBloc extends AudioPlayersBloc {
  final RemoteAudioRepo _remoteAudioRepo = GetIt.instance.get();
  final DeviceAudioRepo _deviceAudioRepo = GetIt.instance.get();

  Stream<List<AlbumModel>> get deviceAudioStream =>
      _deviceAudioRepo.getStream<List<AlbumModel>>((value) => value);

  Stream<CurrentAudioModel> get onlineStream =>
      _remoteAudioRepo.getStream<CurrentAudioModel>((value) => value);

  void onAudioUrlEntered(String newValue) {
    _remoteAudioRepo
        .updateStream(CurrentAudioModel(path: newValue, isPlaying: false, name: getName(newValue)));
  }

  void onSendUrl() {
    try {
      audioPlayer.stop();
      String path = _remoteAudioRepo.dataStream.value.path;
      audioPlayer.play(path, isLocal: false);
      positionChangeListen(DevicePathModel(path: path));
    } catch (Exception) {
      debugPrint('No audio file is playing');
    }
  }

  bool onShuffleClicked(List<AlbumModel> audioModels) {
    if (audioModels != null) {
      MediaModel mediaModel = getRandomTrackFromAlbums(audioModels);
      try {
        audioPlayer.stop();
      } catch (Exception) {
        debugPrint('Error at onShuffleClicked. No audio file to stop playing');
      }
      audioPlayer.play(mediaModel.mediaFile.path);
      historyRepo.addToHistory(mediaModel.mediaFile.path);
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
      audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAlbumRandomPlayClicked. No audio file to stop playing');
    }
    MediaModel mediaModel = album.mediaList[random];
    audioPlayer.play(mediaModel.mediaFile.path);
    historyRepo.addToHistory(mediaModel.mediaFile.path);
    positionChangeListen(mediaModel);
    onCurrentAudioDone(album.mediaList[album.mediaList.length - 1]);
    this.currentAudio =
        CurrentAudioModel(path: mediaModel.mediaFile.path, isPlaying: true, name: mediaModel.getName());
  }

  void onAudioTap(PathModel pathModel, List<PathModel> albumAudio) {
    try {
      audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAudioTap. No audio file to stop playing');
    }
    audioPlayer.play(pathModel.path);
    historyRepo.addToHistory(pathModel.path);
    positionChangeListen(pathModel);
    onCurrentAudioDone(pathModel);
    this.currentAudio = CurrentAudioModel(path: pathModel.path, isPlaying: true, name: pathModel.getName());
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
  }

  MediaModel getRandomTrackFromAlbums(List<AlbumModel> audioModels) {
    final selectedAlbum = audioModels[Random().nextInt(audioModels.length - 1)];
    return selectedAlbum.mediaList[selectedAlbum.mediaList.length - 1];
  }

  void onAddAudioToPlaylistTap(List<CheckValue> checkValues, String path) {
    checkValues.forEach((CheckValue checkValues) {
      if (checkValues.value) {
        playlistRepo.addToPlayList(checkValues.title, path);
      }
    });
  }

  void onAddAlbumToPlaylistTap(List<CheckValue> checkValues, List<MediaModel> mediaModels) {
    checkValues.forEach((CheckValue checkValues) {
      if (checkValues.value) {
        mediaModels.forEach((mediaModel) {
          playlistRepo.addToPlayList(checkValues.title, mediaModel.mediaFile.path);
        });
      }
    });
  }

  @override
  void dispose() {}

  static String getName(String path) {
    List<String> split = path.split('/');
    return split.elementAt(split.length - 1);
  }
}
