import 'dart:math';
import '../model/currentAudio.dart';
import '../model/media.dart';
import 'audioBloc.dart';

class PlayListBloc extends AudioPlayersBloc {
  Stream<List<SavedPathModel>> get playlistStream =>
      playlistRepo.getStream<List<SavedPathModel>>((value) => value);

  bool onOkClicked(String playListName) {
    List<String> isAdded = playlistRepo.addPlayList(playListName);
    if (isAdded != null) {
      List<SavedPathModel> models = [];
      isAdded.forEach((playLists) {
        models.add(SavedPathModel(path: playLists));
      });
      playlistRepo.updateStream(models);
    }
    return isAdded == null ? false : true;
  }

  void loadPlayLists() {
    List<SavedPathModel> savedPlaylists = [];
    List<String> savedList = playlistRepo.getPreference<List>(playlistRepo.playlistsKey);
    if (savedList != null) {
      savedList.forEach((playList) {
        savedPlaylists.add(SavedPathModel(path: playList));
      });
    }
    playlistRepo.updateStream(savedPlaylists);
  }

  List<SavedPathModel> onPlayListTap(String playlistName) {
    List<String> tracks = playlistRepo.getPreference<List>(playlistName);
    List<SavedPathModel> savedTracks;
    if (tracks != null) {
      savedTracks = [];
      tracks.forEach((String path) {
        savedTracks.add(SavedPathModel(path: path));
      });
    }
    return savedTracks;
  }

  bool onPlaylistPlay(String playlistName) {
    List<String> tracks = playlistRepo.getPreference<List>(playlistName);
    if (tracks != null) {
      String path = tracks[Random().nextInt(tracks.length)];
      audioPlayer.play(path);
      historyRepo.addToHistory(path);
      SavedPathModel model = SavedPathModel(path: path);
      positionChangeListen(model);
      onCurrentAudioDone(getRandomTrack(tracks));
      this.currentAudio = CurrentAudioModel(path: model.path, isPlaying: true, name: model.getName());
      return false;
    }
    return true;
  }

  SavedPathModel getRandomTrack(List<String> savedTracks) {
    return SavedPathModel(path: savedTracks[Random().nextInt(savedTracks.length - 1)]);
  }

  @override
  void dispose() {}
}
