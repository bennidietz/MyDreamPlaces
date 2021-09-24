import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/res/colors.dart';

import '../../network/constants.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key,
    this.color = MyColors.primaryColor,
    this.horizontalPadding = defaultPadding,
  }) : super(key: key);

  final Color color;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: 20,
      thickness: 1.5,
      indent: horizontalPadding,
      endIndent: horizontalPadding,
    );
  }
}
