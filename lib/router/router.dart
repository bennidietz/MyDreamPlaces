
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/presentation/dashboard_screen.dart';
import 'package:flutter_music_player_app/presentation/destination_detail_screen.dart';
import 'package:flutter_music_player_app/presentation/my_map.dart';
import 'package:flutter_music_player_app/presentation/not_found_page.dart';
import 'package:flutter_music_player_app/presentation/place_detail_screen.dart';
import 'package:flutter_music_player_app/presentation/welcome_screen.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeRoute:
        return MaterialPageRoute(settings: routeSettings, builder: (_) => DashboardScreen());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case destinationDetailRoute:
        return MaterialPageRoute(settings: routeSettings,
            builder: (_) => DestinationDetailScreen());
      case mapRoute:
        return MaterialPageRoute(settings: routeSettings,
            builder: (_) => MyMap());
      case placeDetailRoute:
        return MaterialPageRoute(settings: routeSettings,
            builder: (_) => PlaceDetailScreen());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }   
}