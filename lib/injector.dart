import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './dataSource/videoDataSource.dart';
import './model/video.dart';
import './dataSource/imageDataSource.dart';

void inject() async {
  final preference = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(preference);

  GetIt.instance.registerLazySingleton<ImageRepo>(() => ImageRepo(BehaviorSubject<VideoModel>()));
  GetIt.instance.registerLazySingleton<VideoRepo>(() => VideoRepo(BehaviorSubject<List<VideoModel>>()));
}
