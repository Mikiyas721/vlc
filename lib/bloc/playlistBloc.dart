import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import '../dataSource/historyDataSource.dart';
import '../model/media.dart';
import '../core/utils/disposable.dart';
import '../dataSource/playlistDataSource.dart';

class PlayListBloc extends Disposable {
  PlaylistRepo _playlistRepo = GetIt.instance.get();
  final HistoryRepo _historyRepo = GetIt.instance.get();
  AudioPlayer _audioPlayer = GetIt.instance.get();

  Stream<List<SavedPathModel>> get playlistStream =>
      _playlistRepo.getStream<List<SavedPathModel>>((value) => value);

  bool onOkClicked(String playListName) {
    List<String> isAdded = _playlistRepo.addPlayList(playListName);
    if (isAdded != null) {
      List<SavedPathModel> models = [];
      isAdded.forEach((playLists) {
        models.add(SavedPathModel(path: playLists));
      });
      _playlistRepo.updateStream(models);
    }
    return isAdded == null ? false : true;
  }

  void loadPlayLists() {
    List<SavedPathModel> savedPlaylists = [];
    List<String> savedList = _playlistRepo.getPreference<List>(_playlistRepo.playlistsKey);
    if (savedList != null) {
      savedList.forEach((playList) {
        savedPlaylists.add(SavedPathModel(path: playList));
      });
    }
    _playlistRepo.updateStream(savedPlaylists);
  }

  List<SavedPathModel> onPlayListTap(String playlistName) {
    List<String> tracks = _playlistRepo.getPreference<List>(playlistName);
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
    List<String> tracks = _playlistRepo.getPreference<List>(playlistName);
    if (tracks != null) {
      String path = tracks[Random().nextInt(tracks.length)];
      _audioPlayer.play(path);
      _historyRepo.addToHistory(path);
      return false;
    }
    return true;
  }

  @override
  void dispose() {}
}
