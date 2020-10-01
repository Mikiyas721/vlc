import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vlc/core/utils/disposable.dart';
import 'package:vlc/dataSource/galleryDataSource.dart';
import 'package:vlc/model/album.dart';
import 'package:vlc/model/media.dart';
import 'package:vlc/model/mediaType.dart';

class ImageBloc extends Disposable {
  GalleryRepo _galleryRepo = GetIt.instance.get();

  get galleryStream => _galleryRepo.getStream<List<AlbumModel>>((value) => value);

  void loadImage() async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.common);
    List<AlbumModel> albumModels = List();
    for (AssetPathEntity album in albums) {
      List<AssetEntity> assets = await album.assetList;
      List<MediaModel> albumMedia = List();
      for (AssetEntity asset in assets) {
        albumMedia.add(MediaModel(
            width: asset.width,
            duration: asset.duration,
            imageFile: await asset.file,
            height: asset.height,
            size: asset.size,
            id: asset.id,
            mediaType: mapMediaType(asset.type)));
      }
      albumModels.add(AlbumModel(
        id: album.id,
        name: getAlbumName(album.name),
        assetCount: album.assetCount,
        imageList: albumMedia,
        firstAlbumFile: await assets[0].file,
      ));
    }
    _galleryRepo.updateStream(albumModels);
  }

  String getAlbumName(String name) {
    if (name == 'Recent')
      return 'All';
    else if (name == '100MEDIA')
      return 'Camera Shots';
    else
      return name;
  }

  @override
  void dispose() {}
}
