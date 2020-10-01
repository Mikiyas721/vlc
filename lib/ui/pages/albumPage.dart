import 'package:flutter/material.dart';
import 'package:vlc/model/mediaType.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';
import 'package:vlc/ui/customWidget/myImageView.dart';
import '../customWidget/myImageView.dart';
import '../../model/media.dart';
import '../customWidget/myDrawer.dart';

class AlbumPage extends StatelessWidget {
  final List<MediaModel> mediaModels;
  final String title;

  AlbumPage({this.title, this.mediaModels});

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
        if (mediaModel.mediaType == MediaType.IMAGE) {
          mediaWidgets.add(GestureDetector(
            child: Container(
              width: width * 0.33,
              height: width * 0.33,
              decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(mediaModel.imageFile), fit: BoxFit.cover)),
              margin: EdgeInsets.all(2),
              child: Align(
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                alignment: Alignment.bottomRight,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return MyImageView(
                  width: mediaModel.width,
                  height: mediaModel.height,
                  imageFile: mediaModel.imageFile,
                );
              }));
            },
          ));
        } else {
          mediaWidgets.add(GestureDetector(
            child: Container(
              width: width * 0.33,
              height: width * 0.33,
              decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(mediaModel.imageFile), fit: BoxFit.cover)),
              margin: EdgeInsets.all(2),
              child: Align(
                child: Icon(
                  Icons.videocam,
                  color: Colors.white,
                ),
                alignment: Alignment.bottomRight,
              ),
            ),
            onTap: () {},
          ));
        }
      });
    }
    return mediaWidgets;
  }
}
