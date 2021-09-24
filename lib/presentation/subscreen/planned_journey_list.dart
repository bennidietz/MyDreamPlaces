import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/list_element.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';

class PlannedJourneyScreen extends StatefulWidget {
  PlannedJourneyScreen({Key? key, this.title, required this.user}) : super(key: key);

  final String? title;
  final User user;

  @override
  _PlannedJourneyScreenState createState() => _PlannedJourneyScreenState();
}

class _PlannedJourneyScreenState extends State<PlannedJourneyScreen> {

  Future<QuerySnapshot<MyJourney>> downloadData() async{
    return journeyRef.where('relatedUserEmail', isEqualTo: widget.user.email).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<MyJourney>>(
        future: downloadData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<MyJourney>> snapshot) {
        return Scaffold(
          body: SingleChildScrollView(
            child: (snapshot.data == null) ?
            DataLoadingText(text: "Reisen werden geladen...") :
            (snapshot.data!.docs.length == 0) ?
            DataLoadingText(text: "Erstelle jetzt deine Reise.") :
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