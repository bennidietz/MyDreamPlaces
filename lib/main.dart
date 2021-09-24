import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/SizeConfig.dart';
import 'package:flutter_music_player_app/network/repository/link_repository.dart';
import 'package:flutter_music_player_app/network/state/link_state.dart';
import 'package:flutter_music_player_app/res/colors.dart';
import 'package:flutter_music_player_app/router/router.dart' as my_router;
import 'package:flutter_music_player_app/router/router_constants.dart';
import 'package:flutter_music_player_app/services/authentification_service.dart';
import 'package:flutter_music_player_app/storage/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await LocalStorage.initializeSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthentificationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (_) => context.read<AuthentificationService>().authStateChanges,
        ),
      ],
      child: Injector(
          inject: [
            Inject<LinkState>(() => LinkState(LinkReposityImpl())),
          ],
      builder: (context) {
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
      }),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<AuthentificationService>(context).authStateChanges;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeScreen App',
      theme: ThemeData(
        primarySwatch: MyColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: my_router.Router.onGenerateRoute,
      initialRoute:
      //LocalStorage.getItem(NAME) != null ? homeRoute : welcomeRoute,

      welcomeRoute
    );
  }
}

