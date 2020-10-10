import 'package:flutter/material.dart';
import '../../../bloc/galleryBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/mediaType.dart';
import '../../customWidget/myImageView.dart';
import '../../customWidget/myVideoPlayer.dart';
import '../../../model/media.dart';

class GalleryAlbumPage extends StatelessWidget {
  final List<MediaModel> mediaModels;
  final String title;

  GalleryAlbumPage({this.title, this.mediaModels});

  @override
  Widget build(BuildContext context) {
    ImageBloc bloc = Provider.of<ImageBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Align(
          alignment: Alignment.topLeft,
          child: GridView.count(
            crossAxisCount: 3,
            children: getImages(context, bloc),
            padding: EdgeInsets.all(5),
          ),
        ));
  }

  List<Widget> getImages(BuildContext context, ImageBloc bloc) {
    List<Widget> mediaWidgets = [];
    if (mediaModels != null) {
      double width = MediaQuery.of(context).size.width;
      for (int i = 0; i < mediaModels.length; i++) {
        mediaWidgets.add(GestureDetector(
          child: Container(
            width: width * 0.33,
            height: width * 0.33,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: mediaModels[i].thumbNail != null
                        ? MemoryImage(mediaModels[i].thumbNail)
                        : FileImage(mediaModels[i].mediaFile),
                    fit: BoxFit.cover)),
            margin: EdgeInsets.all(2),
            child: Align(
              child: Icon(
                mediaModels[i].mediaType == MediaType.IMAGE ? Icons.image : Icons.videocam,
                color: Colors.white,
              ),
              alignment: Alignment.bottomRight,
            ),
          ),
          onTap: () {
            if (mediaModels[i].mediaType == MediaType.IMAGE) {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return MyImageView(
                  family: mediaModels,
                  currentPictureIndex: i,
                );
              }));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                bloc.addHistory(mediaModels[i].mediaFile.path);
                return MyVideoPlayer(
                  family: mediaModels,
                  currentVideoIndex: i,
                );
              }));
            }
          },
        ));
      }
    }
    return mediaWidgets;
  }
}
