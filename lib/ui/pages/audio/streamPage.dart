import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../../model/currentAudio.dart';
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
                        onPressed: ()async{
                          int status = await bloc.onSendUrl();
                          if(status ==0) Toast.show('Playing audio', context);
                          else Toast.show('Could not play audio', context);
                        })
                  ],
                ),
                padding: EdgeInsets.all(10),
              )),
          bottomSheet: StreamBuilder(
              stream: bloc.onlineStream,
              builder: (BuildContext context, AsyncSnapshot<CurrentAudioModel> snapShot) {
                return snapShot.data == null
                    ? Container(height:0, width:0)
                    : snapShot.data.isStopped
                        ? Container(height:0, width:0)
                        : AudioControls(
                            isPlaying: snapShot.data.isPlaying,
                            currentAudioPosition: snapShot.data.currentAudioPosition,
                            audioTotalDuration: snapShot.data.audioDuration,
                            path: snapShot.data.path,
                            family: snapShot.data.family,
                            currentAudioIndex: snapShot.data.currentAudioIndex,
                            audioName: snapShot.data.name,
                          );
              }),
        );
      },
    );
  }
}
