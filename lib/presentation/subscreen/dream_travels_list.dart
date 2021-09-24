import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/list_element.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';

class DreamTravelsScreen extends StatefulWidget {
  DreamTravelsScreen({Key? key, this.title, required this.user}) : super(key: key);


  final String? title;
  final User user;

  @override
  _DreamTravelsScreenState createState() => _DreamTravelsScreenState();
}

class _DreamTravelsScreenState extends State<DreamTravelsScreen> {

  Future<QuerySnapshot<MyJourney>> downloadData() async {
    return journeyRef.where('date', isNull: true)
        .where('relatedUserEmail', isEqualTo: widget.user.email).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<MyJourney>>(
        future: downloadData(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<MyJourney>> snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: (snapshot.data == null) ?
              DataLoadingText(text: "Träume werden geladen...") :
              (snapshot.data!.docs.length == 0) ?
              DataLoadingText(text: "Erstelle jetzt deine erste Traumreise.") :
              Column(
                children: [
                  SizedBox(height: defaultPadding,),
                  ...snapshot.data!.docs.map((journey) =>
                      ListElement(
                        title: journey
                            .data()
                            .title,
                        description: (journey
                            .data()
                            .date != null) ? journey
                            .data()
                            .date! : journey
                            .data()
                            .description,
                        image_url: journey
                            .data()
                            .image_url,
                        callback: () =>
                            Navigator.pushNamed(context, destinationDetailRoute,
                                arguments: journey.data()),
                      )
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}