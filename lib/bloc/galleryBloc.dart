import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vlc/core/repository.dart';
import '../dataSource/historyDataSource.dart';
import '../core/utils/disposable.dart';
import '../dataSource/galleryDataSource.dart';
import '../model/album.dart';
import '../model/media.dart';
import '../model/mediaType.dart';

abstract class MediaBloc extends Disposable {
  void getAlbumModels(List<AssetPathEntity> albums, ListRepo repo) async {
    List<AlbumModel> albumModels = List();
    for (int i = 0; i < albums.length; i++) {
      List<AssetEntity> assets = await albums[i].assetList;
      List<MediaModel> albumMedia = List();
      for (int j = 0; j < assets.length; j++) {
        albumMedia.add(MediaModel(
            width: assets[j].width,
            duration: assets[j].duration,
            file: await assets[j].file,
            height: assets[j].height,
            size: assets[j].size,
            orientation: assets[j].orientation,
            mediaType: mapMediaType(assets[j].type),
            thumbNail: await assets[j].thumbDataWithSize(200, 200)));
      }
      albumModels.add(AlbumModel(
          id: albums[i].id,
          name: getAlbumName(albums[i].name),
          assetCount: albums[i].assetCount,
          mediaList: albumMedia,
          thumbNail: await assets[0].thumbDataWithSize(200, 200),
          loadProgress: i / assets.length));
      repo.updateStream(albumModels);
    }
  }

  String getAlbumName(String name) {
    if (name == 'Recent')
      return 'All';
    else if (name == '100MEDIA')
      return 'Camera Shots';
    else
      return name;
  }
}

class ImageBloc extends MediaBloc {
  GalleryRepo _galleryRepo = GetIt.instance.get();
  ImageRepo _imageRepo = GetIt.instance.get();
  VideoRepo _videoRepo = GetIt.instance.get();
  final HistoryRepo _historyRepo = GetIt.instance.get();

  get galleryStream => _galleryRepo.getStream<List<AlbumModel>>((value) => value);

  get imageStream => _imageRepo.getStream<List<AlbumModel>>((value) => value);

  get videoStream => _videoRepo.getStream<List<AlbumModel>>((value) => value);

  void loadMedia(MediaType loadType) async {
    List<AssetPathEntity> albums;
    if (loadType == MediaType.COMMON)
      albums = await PhotoManager.getAssetPathList(type: RequestType.common);
    else if (loadType == MediaType.IMAGE)
      albums = await PhotoManager.getAssetPathList(type: RequestType.image);
    else if (loadType == MediaType.VIDEO)
      albums = await PhotoManager.getAssetPathList(type: RequestType.video);

    if (loadType == MediaType.COMMON)
      getAlbumModels(albums, _galleryRepo);
    else if (loadType == MediaType.IMAGE)
      getAlbumModels(albums, _imageRepo);
    else if (loadType == MediaType.VIDEO) getAlbumModels(albums, _videoRepo);
  }

  void addHistory(String pathToSave, MediaType mediaType) {
    _historyRepo.addToHistory(pathToSave, mediaType);
  }

  @override
  void dispose() {}
}
