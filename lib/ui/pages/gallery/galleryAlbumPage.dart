import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:vlc/model/mediaType.dart';
import 'package:vlc/ui/customWidget/myImageView.dart';
import 'package:vlc/ui/customWidget/myVideoPlayer.dart';
import '../../customWidget/myImageView.dart';
import '../../../model/media.dart';

class GalleryAlbumPage extends StatelessWidget {
  final List<MediaModel> mediaModels;
  final String title;

  GalleryAlbumPage({this.title, this.mediaModels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Align(
          alignment: Alignment.topLeft,
          child: GridView.count(
            crossAxisCount: 3,
            children: getImages(context),
            padding: EdgeInsets.all(5),
          ),
        ));
  }

  List<Widget> getImages(BuildContext context) {
    List<Widget> mediaWidgets = [];
    if (mediaModels != null) {
      double width = MediaQuery.of(context).size.width;
      mediaModels.forEach((mediaModel) {
        mediaWidgets.add(GestureDetector(
          child: Container(
            width: width * 0.33,
            height: width * 0.33,
            decoration: BoxDecoration(
                image: DecorationImage(image: MemoryImage(mediaModel.thumbNail), fit: BoxFit.cover)),
            margin: EdgeInsets.all(2),
            child: Align(
              child: Icon(
                mediaModel.mediaType == MediaType.IMAGE ? Icons.image : Icons.videocam,
                color: Colors.white,
              ),
              alignment: Alignment.bottomRight,
            ),
          ),
          onTap: () {
            if (mediaModel.mediaType == MediaType.IMAGE) {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return MyImageView(
                  width: mediaModel.width,
                  height: mediaModel.height,
                  imageFile: mediaModel.mediaFile,
                );
              }));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return MyVideoPlayer(
                 videoUrl: mediaModel.mediaFile.path
                );
              }));
            }
          },
        ));
      });
    }
    return mediaWidgets;
  }
}
