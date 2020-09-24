import 'package:flutter/material.dart';
import 'package:vlc/ui/customWidget/myImageView.dart';
import '../../bloc/imageBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/media.dart';
import '../../ui/customWidget/myDrawer.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBloc>(
      blocFactory: () => ImageBloc(),
      builder: (BuildContext context, ImageBloc bloc) {
        bloc.loadImage();
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Image'),
          ),
          body: StreamBuilder(
              stream: bloc.imageStream,
              builder: (BuildContext context, AsyncSnapshot<List<MediaModel>> snapShot) {
                return snapShot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Align(
                        alignment: Alignment.topLeft,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: getImages(context, snapShot.data),
                          padding: EdgeInsets.all(5),
                        ),
                      );
              }),
        );
      },
    );
  }
}

List<Widget> getImages(BuildContext context, List<MediaModel> imageModels) {
  List<Widget> images = [];
  if (imageModels != null) {
    double width = MediaQuery.of(context).size.width;
    imageModels.forEach((imageModel) {
      images.add(GestureDetector(
        child: Container(
            width: width * 0.33,
            height: width * 0.33,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imageModel.mediaPath), fit: BoxFit.cover)),
            margin: EdgeInsets.all(2)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return MyImageView(
              imagePath: imageModel.mediaPath,
            );
          }));
        },
      ));
    });
  }
  return images;
}
