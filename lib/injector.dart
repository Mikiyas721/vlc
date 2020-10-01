import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/media.dart';
import './dataSource/galleryDataSource.dart';
import 'dataSource/audioDataSource.dart';
import 'model/album.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);

  GetIt.instance.registerLazySingleton<GalleryRepo>(() => GalleryRepo(BehaviorSubject<List<AlbumModel>>()));
  GetIt.instance.registerLazySingleton<AudioRepo>(() => AudioRepo(BehaviorSubject<MediaModel>()));
}
