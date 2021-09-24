import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/network/model/place_pages.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';

import '../SizeConfig.dart';

class DestinationDetailScreen extends StatefulWidget {
  DestinationDetailScreen({Key? key}) : super(key: key);

  @override
  _DestinationDetailScreenState createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: PLACE_PAGES(null).length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final myJourney = ModalRoute.of(context)!.settings.arguments as MyJourney;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: () {
                  Navigator.pop(context);
                }),
                  Spacer(),
                  Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () => Navigator.pushNamed(context, mapRoute, arguments: myJourney),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text("Zur Karte", style: TextStyle(fontSize: 17.0),),
                            SizedBox(width: 12.0,),
                            Image.asset("assets/images/map_image.png", height: 30.0, width: 30.0,),
                          ],
                        ),
                      )
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0),
            child: Text(myJourney.title, style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito-Regular',
                fontSize: 4.5 * SizeConfig.textMultiplier
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40.0),
            child: TabBar(
                controller: tabController,
                indicatorColor: Colors.blue[900],
                indicatorWeight: 2.0,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold
                ),
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: <Widget>[
                  ...PLACE_PAGES(myJourney).map((page) =>
                      Tab(
                        child: Text(page.title.toUpperCase(), style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier,
                            fontFamily: 'Nunito'
                        ),),
                      ),
                  )
                ]),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    ...PLACE_PAGES(myJourney).map((place) => place.screen),
                  ]),
            ),
          )
        ],
      ),

    );
  }
}