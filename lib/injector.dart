import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/media.dart';
import './dataSource/galleryDataSource.dart';
import 'dataSource/audioDataSource.dart';
import 'model/album.dart';
import 'model/url.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);
  GetIt.instance.registerSingleton<AudioPlayer>(AudioPlayer());

  GetIt.instance.registerLazySingleton<GalleryRepo>(() => GalleryRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<VideoRepo>(() => VideoRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<ImageRepo>(() => ImageRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<RemoteAudioRepo>(() => RemoteAudioRepo(BehaviorSubject<MediaModel>()));
  GetIt.instance
      .registerLazySingleton<DeviceAudioRepo>(() => DeviceAudioRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<CurrentAudioRepo>(() => CurrentAudioRepo(BehaviorSubject<CurrentAudioModel>()));
}
