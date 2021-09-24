import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/services/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class GeocoderView extends StatefulWidget {
  const GeocoderView({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    required this.latlngCallback,
  }) : super(key: key);

  final double height;
  final double width;
  final Function(LatLng) latlngCallback;

  @override
  _GeocoderViewState createState() => _GeocoderViewState();
}

class _GeocoderViewState extends State<GeocoderView> {
  final TextEditingController _controller = TextEditingController();

  final PopupController _popupLayerController = PopupController();

  Future<List<Location>> getData(String query) async {
    return getLatLng(query);
  }

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        getData(_controller.text);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Location>>(
        future: getData(_controller.text),
        builder:
            (BuildContext context, AsyncSnapshot<List<Location>> locations) {
          return Scaffold(
              body: Container(
              height: widget.height,
              width: widget.width,
              child: Column(
            children: [
                TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(labelText: 'Name des Ortes'),
                ),
                if (locations.data == null || locations.data!.length < 1)
                  DataLoadingText(text: "Es wurden keine Ergebnisse gefunden.")
                else
                  Column(
                    children: [
                      ...locations.data!.map((e) => Text(
                          e.latitude.toString() + " " + e.longitude.toString())),
                      Expanded(
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(locations.data![0].latitude,
                                locations.data![0].longitude),
                            zoom: 10.3,
                            boundsOptions:
                                FitBoundsOptions(padding: EdgeInsets.all(8.0)),
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
                                  markers: [
                                    Marker(
                                      point: LatLng(locations.data![0].latitude,
                                          locations.data![0].longitude),
                                      builder: (_) => FloatingActionButton(
                                        child: Icon(Icons.add),
                                        backgroundColor: Colors.blueAccent[700],
                                        onPressed: () {
                                          widget.latlngCallback.call(LatLng(locations.data![0].latitude,
                                              locations.data![0].longitude));
                                        },
                                      ),
                                      anchorPos: AnchorPos.align(AnchorAlign.top),
                                    ),
                                  ],
                                  markerRotateAlignment:
                                      PopupMarkerLayerOptions.rotationAlignmentFor(
                                          AnchorAlign.top),
                                  popupBuilder:
                                      (BuildContext context, Marker marker) =>
                                          SizedBox()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ],
          ),
              ));
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _controller.dispose();
    super.dispose();
  }
}
