import 'package:flutter/material.dart';
import 'package:vlc/bloc/provider/provider.dart';
import 'package:vlc/bloc/videoBloc.dart';
import 'package:vlc/ui/customWidget/myDrawer.dart';

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
          body: Center(child: Text('Videos')),
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
