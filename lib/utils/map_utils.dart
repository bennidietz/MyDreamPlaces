import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static List<Marker> getMarkers(List<MyPlace> my_places) {
    return my_places
        .map(
          (place) => Marker(
        point: LatLng(place.latitude, place.longitude),
        width: 40,
        height: 40,
        builder: (_) => Text(
          CATEGORIES()[place.category_id]!.icon,
          style: TextStyle(
              fontSize: 30
          ),
        ),//Icon(Icons.location_on, size: 40, color: Colors.blueAccent[700],),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      ),
    ).toList();
  }
}