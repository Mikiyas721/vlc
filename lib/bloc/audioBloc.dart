import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vlc/model/mediaType.dart';
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

  void positionChangeListen({String path, List<PathModel> pathModel, int currentAudioIndex}) {
    audioPlayer.onAudioPositionChanged.listen((Duration duration) async {
      this.currentAudio = CurrentAudioModel(
          path: path,
          family: pathModel,
          currentAudioIndex: currentAudioIndex,
          isPlaying: true,
          // Not for fast forward and fast rewind
          currentAudioPosition: await audioPlayer.getCurrentPosition(),
          audioDuration: await audioPlayer.getDuration(),
          name: pathModel[currentAudioIndex].getName(),
          isStopped: false);
    });
  }

  void onCurrentAudioDone(List<PathModel> pathModels, {int currentAudioIndex, bool isRandom = false}) {
    audioPlayer.onPlayerCompletion.listen((data) async {
      if (isRandom) {
        int randomIndex = Random().nextInt(pathModels.length - 1);
        audioPlayer.play(pathModels[randomIndex].path);
        historyRepo.addToHistory(pathModels[randomIndex].path, MediaType.AUDIO);
        this.currentAudio = CurrentAudioModel(
            isPlaying: true,
            currentAudioPosition: await audioPlayer.getCurrentPosition(),
            audioDuration: await audioPlayer.getDuration(),
            name: pathModels[randomIndex].getName(),
            family: pathModels,
            currentAudioIndex: randomIndex,
            isStopped: false);
      } else {
        currentAudioIndex++;
        if (currentAudioIndex < pathModels.length) {
          audioPlayer.play(pathModels[currentAudioIndex].path);
          historyRepo.addToHistory(pathModels[currentAudioIndex].path, MediaType.AUDIO);
          this.currentAudio = CurrentAudioModel(
              family: pathModels,
              currentAudioIndex: currentAudioIndex,
              isPlaying: true,
              currentAudioPosition: await audioPlayer.getCurrentPosition(),
              audioDuration: await audioPlayer.getDuration(),
              name: pathModels[currentAudioIndex].getName(),
              isStopped: false);
        }
      }
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
    _remoteAudioRepo.updateStream(
        CurrentAudioModel(path: newValue, isPlaying: false, name: getName(newValue), isStopped: true));
  }

  Future<int> onSendUrl() async {
    try {
      audioPlayer.stop();
      String path = _remoteAudioRepo.dataStream.value.path;
      _remoteAudioRepo.updateStream(
          CurrentAudioModel(path: path, isPlaying: false, name: getName(path), isStopped: false));
      positionChangeListen(path: path);
      return await audioPlayer.play(path, isLocal: false);
    } catch (Exception) {
      debugPrint('No audio file is playing');
      return 0;
    }
  }

  bool onShuffleClicked(List<AlbumModel> albumModels) {
    if (albumModels != null) {
      List<PathModel> audioList = getAllMedia(albumModels);
      int randomIndex = Random().nextInt(audioList.length - 1);
      try {
        audioPlayer.stop();
      } catch (Exception) {
        debugPrint('Error at onShuffleClicked. No audio file to stop playing');
      }
      audioPlayer.play(audioList[randomIndex].path);
      historyRepo.addToHistory(audioList[randomIndex].path, MediaType.AUDIO);
      positionChangeListen(pathModel: audioList, currentAudioIndex: randomIndex);
      onCurrentAudioDone(audioList, isRandom: true);
      this.currentAudio = CurrentAudioModel(
          family: audioList,
          currentAudioIndex: randomIndex,
          isPlaying: true,
          name: audioList[randomIndex].getName(),
          isStopped: false);
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
    historyRepo.addToHistory(mediaModel.mediaFile.path, MediaType.AUDIO);
    positionChangeListen(pathModel: album.mediaList, currentAudioIndex: random);
    onCurrentAudioDone(album.mediaList, currentAudioIndex: random);
    this.currentAudio = CurrentAudioModel(
        family: album.mediaList,
        currentAudioIndex: random,
        isPlaying: true,
        name: mediaModel.getName(),
        isStopped: false);
  }

  void onAudioTap(List<PathModel> albumAudio, int currentAudioIndex) {
    try {
      audioPlayer.stop();
    } catch (Exception) {
      debugPrint('Error at onAudioTap. No audio file to stop playing');
    }
    PathModel currentAudioModel = albumAudio[currentAudioIndex];
    audioPlayer.play(currentAudioModel.path);
    historyRepo.addToHistory(currentAudioModel.path, MediaType.AUDIO);
    positionChangeListen(pathModel: albumAudio, currentAudioIndex: currentAudioIndex);
    onCurrentAudioDone(albumAudio, currentAudioIndex: currentAudioIndex);
    this.currentAudio = CurrentAudioModel(
        path: albumAudio[currentAudioIndex].path,
        isPlaying: true,
        name: albumAudio[currentAudioIndex].getName(),
        isStopped: false);
  }

  void loadDeviceAudio() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.audio);
    _deviceAudioRepo.updateStream(await getAlbumModels(albums));
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

  static List<PathModel> getAllMedia(List<AlbumModel> albumModels) {
    List<PathModel> pathModels = [];
    albumModels.forEach((albumModel) {
      pathModels.addAll(albumModel.mediaList);
    });
    return pathModels;
  }
}
