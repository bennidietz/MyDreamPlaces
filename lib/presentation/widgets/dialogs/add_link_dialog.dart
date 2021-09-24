import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/errors/common_error.dart';
import 'package:flutter_music_player_app/network/model/formmodel/link_form_model.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/network/model/link.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../network/constants.dart';
import '../show_snackbar.dart';

class AddLinkDialog extends StatefulWidget {
  AddLinkDialog({Key? key, required this.callback, required this.relatedJourney}) : super(key: key);

  final Function callback;

  final MyJourney relatedJourney;

  @override
  _AddLinkDialogState createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<AddLinkDialog> {
  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return AlertDialog(
        content: Injector(
          inject: [Inject<LinkFormModel>(() => LinkFormModel())],
          builder: (context) {
            final _singletonLinkFormModel = RM.get<LinkFormModel>();
            return Wrap(
              children: [
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Neuer Link",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: defaultPadding,),
                      StateBuilder<LinkFormModel>(
                        observe: () => _singletonLinkFormModel,
                        builder: (context, linkFormModel) {
                          return TextField(
                              decoration: InputDecoration(
                              filled: true,
                              hintText: "Link",
                            ),
                            onChanged: (url) {
                              linkFormModel?.setState(
                                  (state) => state.setUrl(url),
                              );
                            },
                          );
                      }),
                      SizedBox(height: defaultPadding,),
                      StateBuilder<LinkFormModel>(
                        observe: () => _singletonLinkFormModel,
                        builder: (context, linkFormModel) {
                          return TextField(
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Beschreibung",
                            ),
                            onChanged: (description) {
                              linkFormModel?.setState(
                                    (state) => state.setDescription(description),
                              );
                            },
                          );
                        }
                      ),
                      SizedBox(height: defaultPadding * 1.5,),
                      StateBuilder(
                      observe: () => _singletonLinkFormModel,
                      builder: (_, model) {
                        return ElevatedButton(
                            onPressed: () {
                              if (!_singletonLinkFormModel.state.validateData()) {
                                showSnackbar(context: context, message: "Bitte valide Daten einfügen.");
                              } else {
                                _singletonLinkFormModel.setState(
                                    (state) async {
                                      linkRef.add(
                                        Link(
                                            url: state.url!,
                                            description: state.description!,
                                            journey_id: widget.relatedJourney.id,
                                        ),
                                      );
                                      widget.callback.call();
                                      Navigator.pop(context);
                                      showSnackbar(context: context, message: "Der Link wurde hinzugefügt.");
                                    },
                                    onError: (error) {
                                      String? message = (error as CommonError).message;
                                      if (message != null) {
                                        showSnackbar(
                                            color: Colors.red,
                                            message: message,
                                            context: context
                                        );
                                      }
                                    }
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                              child: Text(
                                "Hinzufügen",
                                style: TextStyle(
                                    fontSize: 18.0
                                ),
                              ),
                            )
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          }
        )
    );
  }
}
