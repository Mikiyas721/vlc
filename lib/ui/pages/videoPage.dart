import 'package:flutter/material.dart';
import '../../bloc/provider/provider.dart';
import '../../bloc/videoBloc.dart';
import '../../model/media.dart';
import '../../ui/customWidget/myDrawer.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoBloc>(
      blocFactory: () => VideoBloc(),
      builder: (BuildContext context, VideoBloc bloc) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Video'),
          ),
          body: StreamBuilder(
            stream: bloc.videoStream,
            builder: (BuildContext context, AsyncSnapshot<MediaModel> snapshot) {
              return Center(
                  child: snapshot.data == null ? Text('No Video Found') : Image.asset(snapshot.data.value));
            },
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.play_arrow),
              onPressed: () async {
                await bloc.loadVideo();
              }),
        );
      },
    );
  }
}
