import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

class MiniMap extends StatefulWidget {
  MiniMap({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    required this.latlngCallback,
  }) : super(key: key);

  final double height;
  final double width;
  final Function(LatLng) latlngCallback;

  final PopupController _popupLayerController = PopupController();

  @override
  _MiniMapState createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  final List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(14.655971, -61.024770),
          zoom: 10.3,
          boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
          onTap: (latlang){
            if(_markers.length>=1)
            {
              _markers.clear();
            }
            _onAddMarkerButtonPressed(latlang);
          },
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
              popupController: widget._popupLayerController,
              markers: _markers,
              markerRotateAlignment:
              PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              popupBuilder: (BuildContext context, Marker marker) =>
                  SizedBox()
            ),
          ),
        ],
      ),
    );
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markers.add(Marker(
        point: latlang,
        builder: (_) =>
            FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent[700],
              onPressed: () {
                widget.latlngCallback.call(latlang);
              },
            ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      ));
    });
  }
}
