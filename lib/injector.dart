import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dataSource/directoryDataSource.dart';
import 'dataSource/galleryDataSource.dart';
import 'dataSource/audioDataSource.dart';
import 'dataSource/historyDataSource.dart';
import 'dataSource/playlistDataSource.dart';
import 'model/album.dart';
import 'model/currentAudio.dart';
import 'model/media.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);
  final _audioPlayer = AudioPlayer();

  GetIt.instance.registerSingleton<AudioPlayer>(_audioPlayer);

  GetIt.instance.registerLazySingleton<GalleryRepo>(() => GalleryRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<VideoRepo>(() => VideoRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<ImageRepo>(() => ImageRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance
      .registerLazySingleton<RemoteAudioRepo>(() => RemoteAudioRepo(BehaviorSubject<CurrentAudioModel>()));
  GetIt.instance
      .registerLazySingleton<DeviceAudioRepo>(() => DeviceAudioRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance
      .registerLazySingleton<CurrentAudioRepo>(() => CurrentAudioRepo(BehaviorSubject<CurrentAudioModel>()));
  GetIt.instance
      .registerLazySingleton<PlaylistRepo>(() => PlaylistRepo(BehaviorSubject<List<DevicePathModel>>()));
  GetIt.instance
      .registerLazySingleton<HistoryRepo>(() => HistoryRepo(BehaviorSubject<List<DevicePathModel>>()));
  GetIt.instance
      .registerLazySingleton<DirectoryRepo>(() => DirectoryRepo(BehaviorSubject<List<DevicePathModel>>()));
}
