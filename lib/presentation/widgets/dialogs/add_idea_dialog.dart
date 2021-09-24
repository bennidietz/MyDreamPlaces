import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/errors/common_error.dart';
import 'package:flutter_music_player_app/network/model/checkbox_value.dart';
import 'package:flutter_music_player_app/network/model/formmodel/idea_form_model.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/widgets/show_snackbar.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../network/constants.dart';

class AddIdeaDialog extends StatelessWidget {
  const AddIdeaDialog({
    Key? key,
    required this.callback,
    required this.relatedJourney
  }) : super(key: key);

  final Function callback;

  final MyJourney relatedJourney;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Injector(
          inject: [Inject<IdeaFormModel>(() => IdeaFormModel())],
          builder: (context) {
            final _singletonIdeaFormModel = RM.get<IdeaFormModel>();
            return Wrap(
              children: [
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Neue Idee",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      StateBuilder<IdeaFormModel>(
                        observe: () => _singletonIdeaFormModel,
                        builder: (context, linkFormModel) 
                          => TextField(
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Ideenbeschreibung",
                            ),
                            onChanged: (text) {
                              linkFormModel?.setState(
                                    (state) => state.setText(text),
                              );
                            },
                          ),
                      ),
                      SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (!_singletonIdeaFormModel.state.validateData()) {
                              showSnackbar(context: context, message: "Bitte valide Daten einfügen.");
                            } else {
                              _singletonIdeaFormModel.setState(
                                  (state) async {
                                    ideasRef.add(
                                      CheckboxValue(
                                        text: state.text!,
                                        done: false,
                                        journey_id: relatedJourney.id,
                                      ),
                                    );
                                    callback.call();
                                    Navigator.pop(context);
                                    showSnackbar(context: context, message: "Die Idee wurde hinzugefügt.");
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8.0),
                            child: Text(
                              "Hinzufügen",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
