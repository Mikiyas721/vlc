import 'dart:math';
import 'package:vlc/model/mediaType.dart';

import '../model/currentAudio.dart';
import '../model/media.dart';
import 'audioBloc.dart';

class PlayListBloc extends AudioPlayersBloc {
  Stream<List<DevicePathModel>> get playlistStream =>
      playlistRepo.getStream<List<DevicePathModel>>((value) => value);

  bool onOkClicked(String playListName) {
    List<String> isAdded = playlistRepo.addPlayList(playListName);
    if (isAdded != null) {
      List<DevicePathModel> models = [];
      isAdded.forEach((playLists) {
        models.add(DevicePathModel(path: playLists));
      });
      playlistRepo.updateStream(models);
    }
    return isAdded == null ? false : true;
  }

  void loadPlayLists() {
    List<DevicePathModel> savedPlaylists = [];
    List<String> savedList = playlistRepo.getPreference<List>(playlistRepo.playlistsKey);
    if (savedList != null) {
      savedList.forEach((playList) {
        savedPlaylists.add(DevicePathModel(path: playList));
      });
    }
    playlistRepo.updateStream(savedPlaylists);
  }

  List<DevicePathModel> onPlayListTap(String playlistName) {
    List<String> tracks = playlistRepo.getPreference<List>(playlistName);
    List<DevicePathModel> savedTracks;
    if (tracks != null) {
      savedTracks = [];
      tracks.forEach((String path) {
        savedTracks.add(DevicePathModel(path: path));
      });
    }
    return savedTracks;
  }

  bool onPlaylistPlay(String playlistName) {
    List<PathModel> tracks = playlistRepo.getPlaylistElements();
    if (tracks != null) {
      int random = Random().nextInt(tracks.length);
      audioPlayer.play(tracks[random].path);
      historyRepo.addToHistory(tracks[random].path, MediaType.AUDIO);
      positionChangeListen(
        pathModel: tracks,
      );
      onCurrentAudioDone(tracks, isRandom: true);
      this.currentAudio = CurrentAudioModel(
          path: tracks[random].path, isPlaying: true, name: tracks[random].getName(), isStopped: false);
      return false;
    }
    return true;
  }

  DevicePathModel getRandomTrack(List<String> savedTracks) {
    return DevicePathModel(path: savedTracks[Random().nextInt(savedTracks.length - 1)]);
  }

  @override
  void dispose() {}
}
