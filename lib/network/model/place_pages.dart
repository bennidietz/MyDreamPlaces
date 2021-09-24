import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/miniview/geocoder_view.dart';
import 'package:flutter_music_player_app/presentation/miniview/mini_map.dart';
import 'package:flutter_music_player_app/presentation/subscreen/dream_travels_list.dart';
import 'package:flutter_music_player_app/presentation/subscreen/ideas_list.dart';
import 'package:flutter_music_player_app/presentation/subscreen/link_list.dart';
import 'package:flutter_music_player_app/presentation/subscreen/pack_list.dart';
import 'package:flutter_music_player_app/presentation/subscreen/places_list.dart';
import 'package:flutter_music_player_app/presentation/subscreen/planned_journey_list.dart';
import 'package:latlong2/latlong.dart';

class TabLayout {
  final Widget screen;
  final String title;

  TabLayout({
    required this.screen,
    required this.title,
});
}

List<TabLayout> PLACE_PAGES(MyJourney? myJourney) => [
  TabLayout(screen: PlacesListSubScreen(myJourney: myJourney,), title: "Orte"),
  TabLayout(screen: PackListSubScreen(myJourney: myJourney), title: "Packliste"),
  TabLayout(screen: IdeasSubScreen(myJourney: myJourney), title: "Ideen"),
  TabLayout(screen: LinkSubScreen(myJourney: myJourney), title: "Links"),
];

List<TabLayout> SELECT_LOCATION_PAGES(Function(LatLng) latlngCallback) => [
  TabLayout(screen: MiniMap(
    height: 100,
    latlngCallback: latlngCallback,
  ), title: "Karte"),
  TabLayout(screen: GeocoderView(latlngCallback: latlngCallback,), title: "Adresse"),
];

List<TabLayout> DIFFERENT_JOUNEY_TYPES(User user) => [
  TabLayout(screen: PlannedJourneyScreen(user: user,), title: "Geplante Reise"),
  TabLayout(screen: DreamTravelsScreen(user: user,), title: "TRÄUME"),
];