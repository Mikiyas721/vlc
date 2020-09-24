import 'package:flutter/material.dart';
import '../../bloc/imageBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../model/video.dart';
import '../../ui/customWidget/myDrawer.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageBloc>(
      blocFactory: () => ImageBloc(),
      builder: (BuildContext context, ImageBloc bloc) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Image'),
          ),
          body: StreamBuilder(
              stream: bloc.imageStream,
              builder: (BuildContext context, AsyncSnapshot<VideoModel> snapShot) {
                return Center(
                    child: snapShot.data == null
                        ? Text('No images to display')
                        : Image.asset(snapShot.data.value));
              }),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.file_download),
              onPressed: () async {
                await bloc.loadImage();
              }),
        );
      },
    );
  }
}
