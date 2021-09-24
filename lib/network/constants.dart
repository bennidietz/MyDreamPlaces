import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong2/latlong.dart';

import 'model/journey.dart';
import 'model/place.dart';

const double defaultPadding = 20.0;

List<MyPlace> places = [
  MyPlace(latitude: 14.621,longitude: -61.004, title: "Strand A", description: "Ein wunderschöner Stand mit tollem Sand und einer klasse Aussicht auf den Berg.", category_id: "beach"),
  MyPlace(latitude: 14.60223686414459, longitude: -61.05680067315844,title: "Fort de France",description:  "Toller Hafen", category_id: "city"),
];

List<MyJourney> dreams = [
  MyJourney(id: "1", title: "Budapest",description: "Traumhafte Stadt",image_url: "assets/images/palm_tree.jpeg",latitude: 14.655971, longitude: -61.024770),
];

User? currentUser;

setUser(User? user) {
  currentUser = user;
}

QuerySnapshot<MyPlace>? GLOBAL_PLACES;

MyPlace? getPlaceForLatLng(LatLng latLng, List<MyPlace> myPlaces) {
  print(myPlaces.length);
  for (MyPlace myPlace in myPlaces) {
    if (myPlace.latitude.toStringAsExponential(3) == latLng.latitude.toStringAsExponential(3) &&
        myPlace.longitude.toStringAsExponential(3) == latLng.longitude.toStringAsExponential(3)) {
      return myPlace;
    }
  }
  return null;
}