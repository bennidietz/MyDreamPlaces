import 'package:flutter/material.dart';

class MyColors {
  static const MaterialColor primaryColor = MaterialColor(
    _primatyColorValue,
    <int, Color>{
      50: Color.fromRGBO(24, 128, 243, 0.1),
      100: Color.fromRGBO(24, 128, 243, 0.2),
      200: Color.fromRGBO(24, 128, 243, 0.3),
      300: Color.fromRGBO(24, 128, 243, 0.4),
      400: Color.fromRGBO(24, 128, 243, 0.5),
      500: Color(_primatyColorValue),
      600: Color.fromRGBO(24, 128, 243, 0.7),
      700: Color.fromRGBO(24, 128, 243, 0.8),
      800: Color.fromRGBO(24, 128, 243, 0.9),
      900: Color.fromRGBO(24, 128, 243, 1.0),

    },
  );
  static const int _primatyColorValue = 0xFF075E54;

  static const Color darkBlue = Color.fromRGBO(1, 1, 92, 1.0);
}