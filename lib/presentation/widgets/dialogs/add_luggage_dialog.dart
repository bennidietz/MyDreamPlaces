import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/checkbox_value.dart';
import 'package:flutter_music_player_app/network/model/formmodel/luggage_form_model.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/presentation/widgets/checkbox.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../network/constants.dart';
import '../show_snackbar.dart';

class AddLuggageDialog extends StatelessWidget {
  AddLuggageDialog({
    Key? key,
    required this.callback,
    required this.relatedJourney
  }) : super(key: key);

  final Function callback;

  final MyJourney relatedJourney;

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Injector(
            inject: [Inject<LuggageFormModel>(() => LuggageFormModel())],
            builder: (context) {
              final _singletonLuggageFormModel = RM.get<LuggageFormModel>();
              return Wrap(
                children: [
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Neues Gepäck",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: defaultPadding,),
                        StateBuilder<LuggageFormModel>(
                          observe: () => _singletonLuggageFormModel,
                          builder: (context, luggageFormModel)
                          => TextField(
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Gepäckstück",
                              ),
                            onChanged: (text) {
                              luggageFormModel?.setState(
                                    (state) => state.setText(text),
                              );
                            },
                            ),
                        ),
                        SizedBox(height: defaultPadding,),
                        StateBuilder<LuggageFormModel>(
                          observe: () => _singletonLuggageFormModel,
                          builder: (context, luggageFormModel)
                            => MyCheckBox(
                            text: "Schon eingepackt",
                            onChanged: (value) {
                              checked = value;
                              //luggageFormModel?.setState((state) => state.setDone(value));
                            },
                          ),
                        ),
                        SizedBox(height: defaultPadding * 1.5,),
                        ElevatedButton(
                            onPressed: () {
                              if (!_singletonLuggageFormModel.state.validateData()) {
                              showSnackbar(context: context, message: "Bitte valide Daten einfügen.");
                              } else {
                                _singletonLuggageFormModel.setState(
                                    (state) async {
                                      luggageRef.add(
                                        CheckboxValue(
                                          text: state.text!,
                                          done: checked,
                                          journey_id: relatedJourney.id,
                                        ),
                                      );
                                    }
                                );
                                callback.call();
                                Navigator.pop(context);
                                showSnackbar(context: context, message: "Das Gepäckstück wurde hinzugefügt.");
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
                            ))
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
