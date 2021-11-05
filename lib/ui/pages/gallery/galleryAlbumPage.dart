import 'package:flutter/material.dart';
import '../../../bloc/provider/provider.dart';
import '../../../bloc/galleryBloc.dart';
import '../../../model/mediaType.dart';

class GalleryAlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    ImageBloc bloc = Provider.of<ImageBloc>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text(arguments['title'])),
        body: Align(
          alignment: Alignment.topLeft,
          child: GridView.builder(
            itemCount: arguments['mediaModels'].length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  width: width * 0.33,
                  height: width * 0.33,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: arguments['mediaModels'][index].thumbNail !=
                                  null
                              ? MemoryImage(
                                  arguments['mediaModels'][index].thumbNail)
                              : FileImage(
                                  arguments['mediaModels'][index].mediaFile),
                          fit: BoxFit.cover)),
                  margin: EdgeInsets.all(2),
                  child: Align(
                    child: Icon(
                      arguments['mediaModels'][index].mediaType ==
                              MediaType.IMAGE
                          ? Icons.image
                          : Icons.videocam,
                      color: Colors.white,
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                ),
                onTap: () {
                  bloc.onGalleryAlbumTap(arguments['mediaModels'], index);
                },
              );
            },
            padding: EdgeInsets.all(5),
          ),
        ));
  }
}
