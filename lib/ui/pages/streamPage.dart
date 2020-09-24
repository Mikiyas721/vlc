import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../bloc/audioBloc.dart';
import '../../bloc/provider/provider.dart';
import '../../ui/customWidget/myDrawer.dart';

class StreamPage extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioBloc>(
      blocFactory: () => AudioBloc(),
      builder: (BuildContext context, AudioBloc bloc) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text('Stream'),
          ),
          body: Card(
              margin: EdgeInsets.all(0),
              child: Padding(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Enter a network address with audio file.'),
                          onChanged: (String newValue) {
                            bloc.onAudioUrlEntered(newValue);
                          },
                        )),
                  ],
                ),
                padding: EdgeInsets.all(10),
              )),
          bottomSheet: Card(
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.pause),
                    onPressed: () {
                      audioPlayer.pause();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      String url = bloc.currentUrl;
                      audioPlayer.play(url, isLocal: false);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      audioPlayer.stop();
                    },
                  ),
                ],
              )),
        );
      },
    );
  }
}
