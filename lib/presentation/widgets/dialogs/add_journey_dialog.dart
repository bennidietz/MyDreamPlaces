import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/formmodel/journey_form_model.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/res/colors.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../network/constants.dart';
import '../data_loading_text.dart';
import '../location_selector.dart';
import '../show_snackbar.dart';
import 'package:flutter/services.dart';

class AddJourneyDialog extends StatefulWidget {
  AddJourneyDialog({Key? key, required this.callback, required this.relatedUser}) : super(key: key);

  final Function callback;
  final User relatedUser;

  @override
  _AddJourneyDialogState createState() => _AddJourneyDialogState();
}

class _AddJourneyDialogState extends State<AddJourneyDialog> {
  String? latlngState;

  final TextEditingController _imgController = TextEditingController();

  String? imgUrl = "";

  @override
  void dispose() {
    _imgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Injector(
          inject: [Inject<JourneyFormModel>(() => JourneyFormModel())],
          builder: (context) {
            final _singletonJourneyFormModel = RM.get<JourneyFormModel>();
            return SingleChildScrollView(
                child: Wrap(
              children: [
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Neue Reise",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      StateBuilder<JourneyFormModel>(
                        observe: () => _singletonJourneyFormModel,
                        builder: (context, journeyFormModel) => TextField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Reiseort",
                          ),
                          onChanged: (title) {
                            journeyFormModel?.setState(
                              (state) => state.setTitle(title),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      StateBuilder<JourneyFormModel>(
                        observe: () => _singletonJourneyFormModel,
                        builder: (context, journeyFormModel) => TextField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Beschreibung",
                          ),
                          onChanged: (description) {
                            journeyFormModel?.setState(
                              (state) => state.setDescription(description),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      StateBuilder<JourneyFormModel>(
                        observe: () => _singletonJourneyFormModel,
                        builder: (context, journeyFormModel) => Row(
                          children: [
                            Icon(
                              Icons.date_range_sharp,
                              color: MyColors.primaryColor,
                            ),
                            SizedBox(width: defaultPadding / 2,),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: "Wann findet die Reise statt?",
                                ),
                                onChanged: (date) {
                                  journeyFormModel?.setState(
                                        (state) => state.setDate(date),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ),
                      SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      StateBuilder<JourneyFormModel>(
                          observe: () => _singletonJourneyFormModel,
                          builder: (context, journeyFormModel) => Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: MyColors.primaryColor,
                              ),
                              SizedBox(width: defaultPadding / 2,),
                              Expanded(
                                child: TextField(
                                  controller: _imgController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Link eines Titelbildes",
                                  ),
                                  onChanged: (imageUrl) {
                                    journeyFormModel?.setState(
                                          (state) => state.setImageURL(imageUrl),
                                    );
                                    imgUrl = imageUrl;
                                  },
                                ),
                              ),
                              SizedBox(width: defaultPadding / 3,),
                              IconButton(
                                icon: Icon(
                                  Icons.paste,
                                  color: Colors.deepPurple,
                                ),
                                onPressed: () async {
                                  Clipboard.getData('text/plain')
                                      .then((value) {
                                        setState(() {
                                          if (value?.text != null) {
                                            _imgController.text = value!.text!;
                                          }
                                        });
                                  });
                                }
                              )
                            ],
                          )
                      ),
                      SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      (latlngState == null) ? Text(
                          "Wähle deinen Lieblingsort:"
                      ) : SizedBox(height: 0,),
                      SizedBox(height: defaultPadding * 0.3,),
                      StateBuilder<JourneyFormModel>(
                        observe: () => _singletonJourneyFormModel,
                        builder: (context, placeFormModel)
                        => (latlngState == null) ? LocationSelector(
                            latLngCallback: (latlng) {
                              placeFormModel?.setState(
                                    (state) => state.setLatlng(latlng),
                              );
                              setState(() {
                                latlngState = "Koordinaten festgelegt: \n\n" + latlng.toString();
                              });
                            }
                        ) : DataLoadingText(text: latlngState!),
                      ),
                      SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (!_singletonJourneyFormModel.state
                                .validateData()) {
                              showSnackbar(
                                  context: context,
                                  message: "Bitte valide Daten einfügen.");
                            } else {
                              _singletonJourneyFormModel
                                  .setState((state) async {
                                journeyRef.add(MyJourney(
                                    title: state.title!,
                                    description: state.description!,
                                    image_url: state.imageURL,
                                    date: state.date ?? '',
                                    latitude: state.latitude!,
                                    longitude: state.longitude!,
                                    relatedUserEmail: widget.relatedUser.email,
                                ));
                              });
                              widget.callback.call();
                              Navigator.pop(context);
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
            ));
          }),
    );
  }
}
