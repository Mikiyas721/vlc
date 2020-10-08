import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AudioAlbum extends StatelessWidget {
  final String albumName;
  final void Function() onPlayPressed;
  final void Function() onAlbumTap;
  final void Function() onAlbumAdd;

  AudioAlbum(
      {@required this.albumName, @required this.onPlayPressed, @required this.onAlbumTap, this.onAlbumAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 10,
        color: Colors.blue,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/audio.jpg'), fit: BoxFit.fill)),
              child: onAlbumAdd!=null?Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    size: 35,
                    color: Colors.blue,
                  ),
                  onPressed: onPlayPressed,
                ),
              ):null,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8),
                ),
                Expanded(
                  child: Text(
                    albumName,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
                onAlbumAdd == null
                    ? IconButton(
                        icon: Icon(
                          Icons.playlist_play,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: onPlayPressed,
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: onAlbumAdd),
              ],
            )
          ],
        ),
      ),
      onTap: onAlbumTap,
    );
  }
}
