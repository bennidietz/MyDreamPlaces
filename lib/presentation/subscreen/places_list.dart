import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/dialogs/add_place_dialog.dart';
import 'package:flutter_music_player_app/presentation/widgets/horizontal_divider.dart';
import 'package:flutter_music_player_app/presentation/widgets/icon_fab.dart';
import 'package:flutter_music_player_app/presentation/widgets/list_element.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';

class PlacesListSubScreen extends StatefulWidget {
  PlacesListSubScreen({Key? key, this.title, this.myJourney}) : super(key: key);


  final String? title;

  final MyJourney? myJourney;

  @override
  _PlacesListSubScreenState createState() => _PlacesListSubScreenState();
}

class _PlacesListSubScreenState extends State<PlacesListSubScreen> {

  Future<QuerySnapshot<MyPlace>> downloadData() async{
    return placeRef.where("journey_id", isEqualTo: widget.myJourney!.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<MyPlace>>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<MyPlace>> snapshot) {
          if (snapshot.data != null) GLOBAL_PLACES = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: (snapshot.data == null) ?
              DataLoadingText(text: "Orte werden geladen...") :
              (snapshot.data!.docs.length == 0) ?
              DataLoadingText(text: "Es wurden noch keine Orte gespeichert.") :
              Column(
                  children: [
                    SizedBox(height: defaultPadding / 2,),
                    ...snapshot.data!.docs.map((myPlace) =>
                    // ...places.map((myPlace) =>
                    Column(
                      children: [
                        SizedBox(height: defaultPadding / 2,),
                        MyPlaceListElement(
                          place: myPlace.data(),
                          callback: () => Navigator.pushNamed(context, placeDetailRoute, arguments: myPlace.data()),
                        ),
                        HorizontalDivider(),
                      ],
                    ),
                    ),
                  ]
              ),
            ),
            floatingActionButton: IconFloatingActionButton(
              iconData: Icons.add,
              callback: () {
                if (widget.myJourney != null) {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AddPlaceDialog(
                      relatedJourney: widget.myJourney!,
                      callback: () {
                        setState(() {
                          downloadData();
                        });
                      },
                    );
                  });
                }
              },
            ),
          );
        }
    );
  }
}
