import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/presentation/widgets/example_popup.dart';
import 'package:flutter_music_player_app/utils/map_utils.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatelessWidget {
  MyMap({Key? key}) : super(key: key);

  final PopupController _popupLayerController = PopupController();

  Future<QuerySnapshot<MyPlace>> downloadPlaces() async {
    return placeRef.get();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<MyPlace>>(
        future: downloadPlaces(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<MyPlace>> snapshot) {
          if (!snapshot.hasData && snapshot.data == null) return SizedBox();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0x88000000),
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text(
                "⛵ Sophies & Marcs Reisen ⛵",
                style: TextStyle(color: Colors.white),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: FlutterMap(
              options: MapOptions(
                center: LatLng(14.655971, -61.024770),
                zoom: 2.3,
                boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                onTap: (_) => _popupLayerController.hidePopup(),
              ),
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                ),
                PopupMarkerLayerWidget(
                  options: PopupMarkerLayerOptions(
                    popupController: _popupLayerController,
                    markers: MapUtils.getMarkers(snapshot.data!.docs
                        .toList()
                        .map((e) => e.data())
                        .toList()),
                    markerRotateAlignment:
                        PopupMarkerLayerOptions.rotationAlignmentFor(
                            AnchorAlign.top),
                    popupBuilder: (BuildContext context, Marker marker) {
                      MyPlace? place = getPlaceForLatLng(
                          marker.point,
                          snapshot.data!.docs
                              .toList()
                              .map((e) => e.data())
                              .toList());
                      if (place != null) {
                        return ExamplePopup(marker, place);
                      } else
                        return Text('Nicht gefunden');
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  MyPlace? getPlaceForLatLng(LatLng latLng, List<MyPlace> myPlaces) {
    print(myPlaces.length);
    for (MyPlace myPlace in myPlaces) {
      if (myPlace.latitude.toStringAsExponential(3) ==
              latLng.latitude.toStringAsExponential(3) &&
          myPlace.longitude.toStringAsExponential(3) ==
              latLng.longitude.toStringAsExponential(3)) {
        return myPlace;
      }
    }
    return null;
  }
}
