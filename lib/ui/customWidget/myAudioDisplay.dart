import 'package:flutter/material.dart';

class MyAudioDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(''), fit: BoxFit.fill)),
            child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.play_circle_filled),
                  onPressed: () {},
                )),
          ),
          ListTile(
            title: Text(
              'Unknown Album',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              'Unknown Artist',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: IconButton(icon: Icon(Icons.linear_scale), onPressed: () {}),
          )
        ]),
      ),
    );
  }
}
