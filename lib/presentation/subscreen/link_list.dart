import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/network/model/link.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/dialogs/add_link_dialog.dart';
import 'package:flutter_music_player_app/presentation/widgets/icon_fab.dart';
import 'package:flutter_music_player_app/presentation/widgets/link_widget.dart';

import '../../network/constants.dart';

class LinkSubScreen extends StatefulWidget {
  LinkSubScreen({Key? key, this.title, this.myJourney}) : super(key: key);

  final MyJourney? myJourney;

  final String? title;

  @override
  _LinkSubScreenState createState() => _LinkSubScreenState();
}

class _LinkSubScreenState extends State<LinkSubScreen> {

  Future<QuerySnapshot<Link>> downloadData() async{
    return linkRef.where("journey_id", isEqualTo: widget.myJourney!.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Link>>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Link>> snapshot) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5),
              child: SingleChildScrollView(
                  child: (snapshot.data == null) ?
                  DataLoadingText(text: "Links werden geladen...") :
                  (snapshot.data!.docs.length == 0) ?
                  DataLoadingText(text: "Es wurden noch keine Links gespeichert.") :
                  Column(
                    children: [
                      SizedBox(height: defaultPadding,),
                      ...snapshot.data!.docs.map((snapshot) => LinkWidget(link: snapshot.data())),
                    ]
                ),
              ),
            ),
            floatingActionButton: IconFloatingActionButton(
              iconData: Icons.add,
              callback: () {
                if (widget.myJourney != null) {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AddLinkDialog(
                      callback: () {
                        setState(() {
                          downloadData();
                        });
                      },
                      relatedJourney: widget.myJourney!,
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