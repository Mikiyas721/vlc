import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/stringModel.dart';

class PlaylistRepo extends ListRepo<StringModel> {
  String playlistsKey = 'PLAYLISTS';

  PlaylistRepo(BehaviorSubject<List<StringModel>> subject) : super(subject);

  List<String> get getPlayLists => getPreference<List>(playlistsKey);

  List<String> getPlayListTracks(String playListName) {
    return getPreference<List>(playListName);
  }

  List<String> addPlayList(String newPlayList) {
    List<String> savedPlaylists = getPlayLists;
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

  List<String> addToPlayList(String key, String newTrack) {
    List<String> playListTracks = getPlayListTracks(newTrack);
    if (playListTracks != null) {
      for (String track in playListTracks) {
        if (newTrack == track) return null;
      }
      playListTracks.add(newTrack);
      setPreference<List>(key, playListTracks); // Async
      return playListTracks;
    } else {
      setPreference<List>(key, [newTrack]);
      return [];
    }
  }
}
