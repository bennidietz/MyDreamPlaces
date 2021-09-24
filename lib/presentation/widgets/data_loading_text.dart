import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';

class DataLoadingText extends StatelessWidget {
  const DataLoadingText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: defaultPadding,),
            Center(
              child: Text(text),
            )
          ]
      ),
    );
  }
}
