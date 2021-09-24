import 'package:flutter_music_player_app/network/errors/common_error.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:latlong2/latlong.dart';

class PlaceFormModel {

  String? title;
  String? description;
  LatLng? latLng;
  MyCategory? category;
  

  void setTitle(String title) {
    if (!validateText(title)) throw CommonError(message: "Der Titel ist nicht valide");
    this.title = title;
  }

  void setDescription(String description) {
    if (!validateText(description)) throw CommonError(message: "Die Beschreibung ist nicht valide");
    this.description = description;
  }

  void setLatLng(LatLng latlng) {
    this.latLng = latlng;
  }

  bool validateText(String text) => text.length > 3;

  bool validateData() {
    return this.title != null && this.description != null && this.latLng != null &&
        validateText(this.title!) && validateText(this.description!);
  }
}