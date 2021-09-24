import 'package:flutter_music_player_app/network/errors/common_error.dart';
import 'package:latlong2/latlong.dart';

class JourneyFormModel {

  String? title;
  String? description;
  String? date;
  double? latitude;
  double? longitude;
  String? imageURL;


  void setTitle(String title) {
    if (!validateText(title)) throw CommonError(message: "Text darf nicht leer sein");
    this.title = title;
  }

  void setDescription(String description) {
    if (!validateText(description)) throw CommonError(message: "Text darf nicht leer sein");
    this.description = description;
  }

  void setDate(String date) {
    if (!validateText(date)) throw CommonError(message: "Text darf nicht leer sein");
    this.date = date;
  }

  setImageURL(String imageUrl) {
    if (!_validURL(imageUrl)) throw CommonError(message: "Die URL vom Bild ist nicht valide");
    this.imageURL = imageUrl;
  }

  bool _validURL(String url) => Uri.parse(url).isAbsolute;

  void setLatlng(LatLng latLng) {
    this.latitude = latLng.latitude;
    this.longitude = latLng.longitude;
  }

  bool validateText(String text) => text.length > 0;

  bool validateData() {
    return this.title != null && validateText(this.title!) &&
        this.description != null && validateText(this.description!) &&
        this.latitude != null && this.longitude != null;
  }

}