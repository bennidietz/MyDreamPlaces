import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/place_pages.dart';
import 'package:flutter_music_player_app/presentation/widgets/dialogs/add_journey_dialog.dart';
import 'package:flutter_music_player_app/presentation/widgets/icon_fab.dart';
import 'package:flutter_music_player_app/services/authentification_service.dart';
import 'package:flutter_music_player_app/storage/local_storage.dart';
import 'package:flutter_music_player_app/storage/storage_keys.dart';
import 'package:provider/provider.dart';

import '../SizeConfig.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  late User user;

  @override
  Widget build(BuildContext context) {
    try {
      user = ModalRoute.of(context)!.settings.arguments as User;
    } on Exception catch (e) {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
            child: Row(
              children: <Widget>[
                Spacer(),
                Card(
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () =>
                          context.read<AuthentificationService>().signOut(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(fontSize: 17.0),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Icon(Icons.logout),
                            //Image.asset("assets/images/map_image.png", height: 30.0, width: 30.0,),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0),
            child: Text(
              (LocalStorage.getItem(NAME) != null
                  ? ("Hallo " + LocalStorage.getItem(NAME)! + "!")
                  : "MyAdventure"),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Nunito-Regular',
                  fontSize: 4.5 * SizeConfig.textMultiplier),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0),
            child: TabBar(
                controller: tabController,
                indicatorColor: Colors.blue[900],
                indicatorWeight: 2.0,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: <Widget>[
                  ...DIFFERENT_JOUNEY_TYPES(user).map(
                    (type) => Tab(
                      child: Text(
                        type.title.toUpperCase(),
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier,
                            fontFamily: 'Nunito'),
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: Container(
              child: TabBarView(controller: tabController, children: <Widget>[
                ...DIFFERENT_JOUNEY_TYPES(user).map((type) => type.screen),
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: IconFloatingActionButton(
        iconData: Icons.add,
        callback: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddJourneyDialog(
                  callback: () {},
                  relatedUser: user,
                );
              });
        },
      ),
    );
  }
}
