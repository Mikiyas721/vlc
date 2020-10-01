import 'package:flutter/material.dart';

class AudioAlbum extends StatelessWidget {
  final String albumName;
  final void Function() onPlayPressed;
  final void Function() onAlbumTap;

  AudioAlbum({@required this.albumName, @required this.onPlayPressed, @required this.onAlbumTap});

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
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_filled,
                    size: 35,
                  ),
                  onPressed: onPlayPressed,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    albumName,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ],
            )
          ],
        ),
      ),
      onTap: onAlbumTap,
    );
  }
}
