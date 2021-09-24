import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'network/model/category.dart';
import 'network/model/place.dart';

class ExamplePopup extends StatefulWidget {
  final Marker marker;
  final List<MyPlace> myPlaces;

  ExamplePopup(this.marker, this.myPlaces, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState(marker, myPlaces);
}

class _ExamplePopupState extends State<ExamplePopup> {
  final Marker _marker;

  final List<MyPlace> myPlaces;

 late MyPlace place;

  _ExamplePopupState(this._marker, this.myPlaces) {
    if (getPlaceForLatLng(this._marker.point, myPlaces) != null) {
      place = getPlaceForLatLng(this._marker.point, myPlaces)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Text(
                CATEGORIES()[place.category_id]?.icon ?? CATEGORIES()[OTHERS]!.icon,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
            _cardDescription(context, place),
            IconButton(icon: Icon(Icons.navigation_outlined), onPressed: () =>
                MapsLauncher.launchCoordinates(place.latitude, place.longitude)
            )
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context, MyPlace place) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              place.title,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 2.0,),
            Text(
              "(" + CATEGORIES()[place.category_id]!.name + ")",
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11.0
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Container(
              width: 150,
              child: Text(
                place.description,
                style: const TextStyle(fontSize: 14.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}