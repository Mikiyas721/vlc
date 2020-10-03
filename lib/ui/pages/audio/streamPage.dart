import 'package:flutter/material.dart';
import 'package:vlc/model/currentAudio.dart';
import '../../../ui/customWidget/audioControls.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../customWidget/myDrawer.dart';

class StreamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioBloc>(
      blocFactory: () => AudioBloc(),
      builder: (BuildContext context, AudioBloc bloc) {
        return Scaffold(
          drawer: MyDrawer(isStreamSelected: true),
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(labelText: 'Enter a network address with audio file.'),
                          onChanged: (String newValue) {
                            bloc.onAudioUrlEntered(newValue);
                          },
                        )),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 35,
                          color: Colors.blue,
                        ),
                        onPressed: bloc.onSendUrl)
                  ],
                ),
                padding: EdgeInsets.all(10),
              )),
          bottomSheet:
              StreamBuilder(
                stream: bloc.onlineStream,
                  builder: (BuildContext context, AsyncSnapshot<CurrentAudioModel> snapShot) {
            return snapShot.data == null
                ? AudioControls(
                    path: '',
                    audioName: '',
                    currentAudioPosition: 0,
                    audioTotalDuration: 1,
                    isPlaying: false,
                  )
                : AudioControls(
                    path: snapShot.data.path,
                    audioName: snapShot.data.name,
                    currentAudioPosition: snapShot.data.currentAudioPosition,
                    audioTotalDuration: snapShot.data.audioDuration,
                    isPlaying: snapShot.data.isPlaying,
                  );
          }),
        );
      },
    );
  }
}
