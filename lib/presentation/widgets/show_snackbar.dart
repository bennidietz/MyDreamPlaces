import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/res/colors.dart';

showSnackbar(
    {required BuildContext context,
       required String message,
      Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? MyColors.primaryColor,
      content: Text(message),
    ),
  );
}