import 'package:flutter/material.dart';
import '../../../ui/customWidget/audioControlls.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../customWidget/myDrawer.dart';
import 'audioAlbumPage.dart';

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
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(labelText: 'Enter a network address with audio file.'),
                          onChanged: (String newValue) {
                            bloc.onAudioUrlEntered(newValue);
                          },
                        )),
                  ],
                ),
                padding: EdgeInsets.all(10),
              )),
          bottomSheet: AudioControls(audioPlayer: audioPlayer,),
        );
      },
    );
  }
}
