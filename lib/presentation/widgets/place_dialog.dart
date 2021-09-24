import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/utils/url_utils.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../network/constants.dart';

class PlaceDialog extends StatelessWidget {
  const PlaceDialog({
    Key? key,
    required this.place,
  }) : super(key: key);

  final MyPlace place;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Wrap(
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          place.name ?? 'Unbekannter Ort',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        (place.from != null)
                            ? Text(
                                'von ${place.from!}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Text(
                      CATEGORIES()[place.category]?.icon ??
                          CATEGORIES()[OTHERS]!.icon,
                      style: TextStyle(
                        fontSize: 35.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                Text(
                  place.description,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                (place.imageUrl != null)
                    ? Image.network(place.imageUrl!)
                    : SizedBox(),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                (place.website != null)
                    ? ElevatedButton(
                        onPressed: () => openUrl(place.website!),
                        child: Text('🌎  Mehr Informationen'))
                    : SizedBox(),
                SizedBox(
                  height: defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () => MapsLauncher.launchCoordinates(
                      place.latitude, place.longitude),
                  child: Text('🗺  ️Hier will ich hin'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
