import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_music_player_app/example_popup.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/network/model/place_pages.dart';
import 'package:flutter_music_player_app/utils/map_utils.dart';
import 'package:latlong2/latlong.dart';

class PlaceDetailScreen extends StatefulWidget {
  PlaceDetailScreen({Key? key, this.title}) : super(key: key);


  final String? title;

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final PopupController _popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final myPlace = ModalRoute.of(context)!.settings.arguments as MyPlace;
    final categoryData = CATEGORIES()[myPlace.category_id];

    List<Marker> marker = MapUtils.getMarkers([myPlace]);
    if (marker.length > 0) _popupLayerController.showPopupFor(marker[0]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                  Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
                        Navigator.pop(context);
                      }),
                      SizedBox(width: 20.0,),
                      Text(myPlace.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                Spacer(),
                Text(
                  categoryData?.icon ?? "",
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  // actual content
                  Text(
                    myPlace.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: defaultPadding,),
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(14.655971, -61.024770),
                        zoom: 10.3,
                        boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                        onTap: (_) => _popupLayerController.hidePopup(),
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
                            markers: marker,
                            markerRotateAlignment:
                            PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                            popupBuilder: (BuildContext context, Marker marker) =>
                                ExamplePopup(marker, [myPlace]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}