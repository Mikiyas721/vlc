import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './dataSource/videoDataSource.dart';
import './model/media.dart';
import './dataSource/imageDataSource.dart';
import 'dataSource/audioDataSource.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);

  GetIt.instance.registerLazySingleton<ImageRepo>(() => ImageRepo(BehaviorSubject<List<MediaModel>>()));
  GetIt.instance.registerLazySingleton<VideoRepo>(() => VideoRepo(BehaviorSubject<MediaModel>()));
  GetIt.instance.registerLazySingleton<AudioRepo>(() => AudioRepo(BehaviorSubject<MediaModel>()));
}
