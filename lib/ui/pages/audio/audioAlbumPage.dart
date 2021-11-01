import 'package:flutter/material.dart';
import '../../../bloc/audioBloc.dart';
import '../../../bloc/provider/provider.dart';
import '../../../model/currentAudio.dart';
import '../../../ui/customWidget/audioControls.dart';
import '../../../ui/customWidget/myListTIle.dart';

class AudioAlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;

    return BlocProvider(
        blocFactory: () => AudioBloc(context),
        builder: (BuildContext context, AudioBloc bloc) {
          return Scaffold(
            appBar: AppBar(
              title: Text(arguments['title']),
            ),
            body: ListView.builder(
              itemCount: arguments['albumAudio'].length,
              itemBuilder: (BuildContext context, int index) {
                return MyListTile(
                  leadingIcon: Icons.audiotrack,
                  title: arguments['albumAudio'][index].getName(),
                  path: arguments['albumAudio'][index].path,
                  onTap: () {
                    bloc.onAudioTap(arguments['albumAudio'], index);
                  },
                  onAddAudioTap: arguments['isPlaylist']
                      ? null
                      : () {
                          bloc.onAddAudioTap(arguments['albumAudio'][index]);
                        },
                );
              },
            ),
            bottomSheet: StreamBuilder(
                stream: bloc.playingStream,
                builder: (BuildContext context,
                    AsyncSnapshot<CurrentAudioModel> snapShot) {
                  return snapShot.data == null
                      ? Container(height: 0, width: 0)
                      : snapShot.data.isStopped
                          ? Container(height: 0, width: 0)
                          : AudioControls(
                              isPlaying: snapShot.data.isPlaying,
                              currentAudioPosition:
                                  snapShot.data.currentAudioPosition,
                              audioTotalDuration: snapShot.data.audioDuration,
                              path: snapShot.data.path,
                              family: snapShot.data.family,
                              currentAudioIndex:
                                  snapShot.data.currentAudioIndex,
                              audioName: snapShot.data.name,
                            );
                }),
          );
        });
  }
}
