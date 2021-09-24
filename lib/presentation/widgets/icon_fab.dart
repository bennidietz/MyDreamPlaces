
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';

class IconFloatingActionButton extends StatelessWidget {
  const IconFloatingActionButton({
    Key? key,
    required this.callback,
    required this.iconData,
  }) : super(key: key);

  final Function() callback;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 85,
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent[700],
        onPressed: callback,
      ),
    );
  }
}