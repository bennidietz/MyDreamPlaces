import 'package:geocoding/geocoding.dart';

Future<List<Location>> getLatLng(String adress) async {
  return await locationFromAddress(adress);
}