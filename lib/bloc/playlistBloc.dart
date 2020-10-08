import 'package:get_it/get_it.dart';
import '../model/media.dart';
import '../core/utils/disposable.dart';
import '../dataSource/playlistDataSource.dart';

class PlayListBloc extends Disposable {
  PlaylistRepo _playlistRepo = GetIt.instance.get();

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

  List<String> onPlayListTap(String playlistName) {
    List<String> tracks = _playlistRepo.getPreference<List>(playlistName);
    print(tracks);
    return tracks;
  }

  bool onPlaylistPlay(String playlistName) {
    List<String> tracks = _playlistRepo.getPreference<List>(playlistName);
    if (tracks != null) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {}
}
