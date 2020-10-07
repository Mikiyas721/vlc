import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/stringModel.dart';

class PlaylistRepo extends ListRepo<StringModel> {
  String playlistsKey = 'PLAYLISTS';

  PlaylistRepo(BehaviorSubject<List<StringModel>> subject) : super(subject);

  List<String> addPlayList(String newPlayList) {
    List<String> savedPlaylists = getPreference<List>(playlistsKey);
    if (savedPlaylists != null) {
      for (String playlist in savedPlaylists) {
        if (newPlayList == playlist) return null;
      }
      savedPlaylists.add(newPlayList);
      setPreference<List>(playlistsKey, savedPlaylists); // Async
      return savedPlaylists;
    } else {
      List<String> playList = [];
      playList.add(newPlayList);
      setPreference<List>(playlistsKey, playList); // Async
      return playList;
    }
  }
}
