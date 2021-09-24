import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/link.dart';
import 'package:flutter_music_player_app/utils/url_utils.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({
    Key? key,
    required this.link
  }) : super(key: key);

  final Link link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openUrl(link.url),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.link_sharp),
            SizedBox(width: defaultPadding,),
            Text(
              link.description,
              style: TextStyle(
                fontSize: 15.0,
                //color: MyColors.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}