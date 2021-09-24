import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/checkbox_value.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/widgets/checkbox.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/dialogs/add_idea_dialog.dart';
import 'package:flutter_music_player_app/presentation/widgets/icon_fab.dart';

import '../../network/constants.dart';

class IdeasSubScreen extends StatefulWidget {
  IdeasSubScreen({Key? key, this.title, this.myJourney}) : super(key: key);

  final MyJourney? myJourney;

  final String? title;

  @override
  _IdeasSubScreenState createState() => _IdeasSubScreenState();
}

class _IdeasSubScreenState extends State<IdeasSubScreen> {

  Future<QuerySnapshot<CheckboxValue>> downloadData() async{
    return ideasRef.where("journey_id", isEqualTo: widget.myJourney!.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<CheckboxValue>>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<CheckboxValue>> snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: (snapshot.data == null) ?
              DataLoadingText(text: "Ideen werden geladen...") :
              (snapshot.data!.docs.length == 0) ?
              DataLoadingText(text: "Es wurden noch keine Ideen gespeichert.") :
              Column(
                  children: [
                    SizedBox(height: defaultPadding,),
                    ...snapshot.data!.docs.map((idea) =>
                        MyCheckBox(
                          text: idea.data().text,
                          defaultState: idea.data().done,
                          onChanged: (value) {
                            ideasRef.doc(idea.id).update({'done': value});
                          },
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
                    return AddIdeaDialog(
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