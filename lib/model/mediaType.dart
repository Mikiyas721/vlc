import 'package:photo_manager/photo_manager.dart';

enum MediaType { AUDIO, IMAGE, VIDEO, COMMON }

mapMediaType(AssetType assetType) {
  if (assetType == AssetType.audio) return MediaType.AUDIO;
  if (assetType == AssetType.image) return MediaType.IMAGE;
  if (assetType == AssetType.video) return MediaType.VIDEO;
}
