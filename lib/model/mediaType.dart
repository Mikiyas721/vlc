import 'package:photo_manager/photo_manager.dart';

enum MediaType { AUDIO, IMAGE, VIDEO, COMMON }

MediaType getMediaType(String mediaTypeString) {
  if (mediaTypeString == 'MediaType.AUDIO')
    return MediaType.AUDIO;
  else if (mediaTypeString == 'MediaType.IMAGE')
    return MediaType.IMAGE;
  else if (mediaTypeString == 'MediaType.VIDEO')
    return MediaType.VIDEO;
  else
    return MediaType.COMMON;
}

mapMediaType(AssetType assetType) {
  if (assetType == AssetType.audio) return MediaType.AUDIO;
  if (assetType == AssetType.image) return MediaType.IMAGE;
  if (assetType == AssetType.video) return MediaType.VIDEO;
}
