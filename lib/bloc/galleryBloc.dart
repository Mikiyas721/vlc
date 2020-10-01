import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import '../core/utils/disposable.dart';
import '../dataSource/galleryDataSource.dart';
import '../model/album.dart';
import '../model/media.dart';
import '../model/mediaType.dart';

abstract class MediaBloc extends Disposable {
  Future<List<AlbumModel>> getAlbumModels(List<AssetPathEntity> albums) async {
    List<AlbumModel> albumModels = List();
    for (AssetPathEntity album in albums) {
      List<AssetEntity> assets = await album.assetList;
      List<MediaModel> albumMedia = List();
      for (AssetEntity asset in assets) {
        albumMedia.add(MediaModel(
            width: asset.width,
            duration: asset.duration,
            mediaFile: await asset.file,
            height: asset.height,
            size: asset.size,
            id: asset.id,
            mediaType: mapMediaType(asset.type)));
      }
      albumModels.add(AlbumModel(
        id: album.id,
        name: getAlbumName(album.name),
        assetCount: album.assetCount,
        mediaList: albumMedia,
        firstAlbumFile: await assets[0].file,
      ));
    }
    return albumModels;
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
      albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    if (loadType == MediaType.COMMON)
      _galleryRepo.updateStream(await getAlbumModels(albums));
    else if (loadType == MediaType.IMAGE)
      _imageRepo.updateStream(await getAlbumModels(albums));
    else if (loadType == MediaType.VIDEO) _videoRepo.updateStream(await getAlbumModels(albums));
  }

  @override
  void dispose() {}
}
