import 'package:get_it/get_it.dart';
import '../model/stringModel.dart';
import '../core/utils/disposable.dart';
import '../dataSource/playlistDataSource.dart';

class PlayListBloc extends Disposable {
  PlaylistRepo _playlistRepo = GetIt.instance.get();

  Stream<List<StringModel>> get playlistStream =>
      _playlistRepo.getStream<List<StringModel>>((value) => value);

  bool onOkClicked(String playListName) {
    List<String> isAdded = _playlistRepo.addPlayList(playListName);
    if (isAdded != null) {
      List<StringModel> models = [];
      isAdded.forEach((playLists) {
        models.add(StringModel(value: playLists));
      });
      _playlistRepo.updateStream(models);
    }
    return isAdded == null ? false : true;
  }

  void loadPlayLists() {
    List<StringModel> savedPlaylists = [];
    List<String> savedList = _playlistRepo.getPreference<List>(_playlistRepo.playlistsKey);
    if (savedList != null) {
      savedList.forEach((playList) {
        savedPlaylists.add(StringModel(value: playList));
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
