import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/SizeConfig.dart';
import 'package:flutter_music_player_app/res/colors.dart';
import 'package:flutter_music_player_app/router/router.dart' as my_router;
import 'package:flutter_music_player_app/router/router_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MyMaterialApp();
          },
        );
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HomeScreen App',
        theme: ThemeData(
          primarySwatch: MyColors.primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: my_router.Router.onGenerateRoute,
        initialRoute: mapRoute);
  }
}
