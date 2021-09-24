import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/utils/map_utils.dart';
import 'package:latlong2/latlong.dart';

import '../example_popup.dart';

class MyMap extends StatelessWidget {
  MyMap({Key? key}) : super(key: key);

  final PopupController _popupLayerController = PopupController();

  MyJourney? myJourney;

  Future<QuerySnapshot<MyPlace>> downloadPlaces() async{
    return placeRef.where("journey_id", isEqualTo: myJourney?.id).get();
  }

  Widget build(BuildContext context) {
    myJourney = ModalRoute
        .of(context)!
        .settings
        .arguments as MyJourney;
    return FutureBuilder<QuerySnapshot<MyPlace>>(
        future: downloadPlaces(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<MyPlace>> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0x88000000),
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text(
                "Kartenübersicht",
                style: TextStyle(color: Colors.white),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: FlutterMap(
              options: MapOptions(
                center: LatLng(14.655971, -61.024770),
                zoom: 10.3,
                boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                onTap: (_) => _popupLayerController
                    .hidePopup(),
              ),
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
                  Navigator.pop(context);
                }),
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    popupController: _popupLayerController,
                    markers: MapUtils.getMarkers(snapshot.data!.docs.toList().map((e) => e.data()).toList()),
                    markerRotateAlignment:
                    PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                    popupBuilder: (BuildContext context, Marker marker) =>
                        ExamplePopup(marker, snapshot.data!.docs.toList().map((e) => e.data()).toList()),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
