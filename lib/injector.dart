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

Future<void> inject() async {
  final getItInstance = GetIt.instance;

  getItInstance.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  getItInstance.registerSingleton<AudioPlayer>(AudioPlayer());

  getItInstance.registerLazySingleton<GalleryRepo>(
      () => GalleryRepo(BehaviorSubject<List<AlbumModel>>()));
  getItInstance.registerLazySingleton<VideoRepo>(
      () => VideoRepo(BehaviorSubject<List<AlbumModel>>()));
  getItInstance.registerLazySingleton<ImageRepo>(
      () => ImageRepo(BehaviorSubject<List<AlbumModel>>()));
  getItInstance.registerLazySingleton<RemoteAudioRepo>(
      () => RemoteAudioRepo(BehaviorSubject<CurrentAudioModel>()));
  getItInstance.registerLazySingleton<DeviceAudioRepo>(
      () => DeviceAudioRepo(BehaviorSubject<List<AlbumModel>>()));
  getItInstance.registerLazySingleton<CurrentAudioRepo>(
      () => CurrentAudioRepo(BehaviorSubject<CurrentAudioModel>()));
  getItInstance.registerLazySingleton<PlaylistRepo>(
      () => PlaylistRepo(BehaviorSubject<List<DevicePathModel>>()));
  getItInstance.registerLazySingleton<HistoryRepo>(
      () => HistoryRepo(BehaviorSubject<List<DevicePathModel>>()));
  getItInstance.registerLazySingleton<DirectoryRepo>(
      () => DirectoryRepo(BehaviorSubject<List<DevicePathModel>>()));
}
