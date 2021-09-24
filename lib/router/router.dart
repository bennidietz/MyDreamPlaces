import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/presentation/my_map.dart';
import 'package:flutter_music_player_app/presentation/not_found_page.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case mapRoute:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => MyMap());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
