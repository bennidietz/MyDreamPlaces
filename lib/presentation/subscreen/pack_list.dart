import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/checkbox_value.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/widgets/checkbox.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/dialogs/add_luggage_dialog.dart';
import 'package:flutter_music_player_app/presentation/widgets/icon_fab.dart';

import '../../network/constants.dart';

class PackListSubScreen extends StatefulWidget {
  PackListSubScreen({Key? key, this.title, this.myJourney}) : super(key: key);

  final MyJourney? myJourney;

  final String? title;

  @override
  _PackListSubScreenState createState() => _PackListSubScreenState();
}

class _PackListSubScreenState extends State<PackListSubScreen> {

  Future<QuerySnapshot<CheckboxValue>> downloadData() async{
    return luggageRef.where("journey_id", isEqualTo: widget.myJourney!.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<CheckboxValue>>(
        future: downloadData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<CheckboxValue>> snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: (snapshot.data == null) ?
              DataLoadingText(text: "Gepächstücke werden geladen...") :
              (snapshot.data!.docs.length == 0) ?
              DataLoadingText(text: "Es wurden noch keine Gepächstücke gespeichert.") :
              Column(
                  children: [
                    SizedBox(height: defaultPadding / 2,),
                    ...snapshot.data!.docs.map((checkbox) =>
                    Column(
                      children: [
                        SizedBox(height: defaultPadding / 2,),
                        MyCheckBox(
                          text: checkbox.data().text,
                          defaultState: checkbox.data().done,
                          onChanged: (value) {
                            luggageRef.doc(checkbox.id).update({'done': value});
                          },
                        ),
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
                    return AddLuggageDialog(
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