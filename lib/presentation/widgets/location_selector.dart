import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/SizeConfig.dart';
import 'package:flutter_music_player_app/network/model/place_pages.dart';
import 'package:latlong2/latlong.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({
    Key? key,
    required this.latLngCallback,
  }) : super(key: key);

  final Function(LatLng) latLngCallback;

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: tabController,
            indicatorColor: Colors.blue[900],
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.black,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold
            ),
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: <Widget>[
              ...['Karte', 'Adresse'].map((title) =>
                  Tab(
                    child: Text(title.toUpperCase(), style: TextStyle(
                        fontSize: 1.8 * SizeConfig.textMultiplier,
                        fontFamily: 'Nunito'
                    ),),
                  ),
              )
            ]),
        SizedBox(height: 10,),
        Container(
          height: 200,
          width: double.infinity,
          child: TabBarView(
              controller: tabController,
              children: <Widget>[
                ...SELECT_LOCATION_PAGES(
                      (latlng) => widget.latLngCallback.call(latlng),
                ).map((place) => place.screen),
              ]),
        ),
      ],
    );
  }
}