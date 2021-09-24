import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:flutter_music_player_app/network/model/formmodel/place_form_model.dart';
import 'package:flutter_music_player_app/network/model/journey.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/network/model/place_pages.dart';
import 'package:flutter_music_player_app/presentation/widgets/category_card_widget.dart';
import 'package:flutter_music_player_app/presentation/widgets/data_loading_text.dart';
import 'package:flutter_music_player_app/presentation/widgets/show_snackbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../SizeConfig.dart';
import '../../../network/constants.dart';
import '../location_selector.dart';

class AddPlaceDialog extends StatefulWidget {
  AddPlaceDialog({Key? key, required this.callback, required this.relatedJourney}) : super(key: key);

  final Function callback;

  final MyJourney relatedJourney;

  @override
  _AddPlaceDialogState createState() => _AddPlaceDialogState();
}

class _AddPlaceDialogState extends State<AddPlaceDialog> with SingleTickerProviderStateMixin {

  String? latlngState;
  String category_id = "others";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Injector(
            inject: [Inject<PlaceFormModel>(() => PlaceFormModel())],
            builder: (context) {
              final _singletonPlaceFormModel = RM.get<PlaceFormModel>();
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    Container(
                      width: 600,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Neuer Lieblingsort",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: defaultPadding,),
                          StateBuilder<PlaceFormModel>(
                            observe: () => _singletonPlaceFormModel,
                            builder: (context, placeFormModel) 
                            => TextField(
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Titel",
                              ),
                              onChanged: (title) {
                                placeFormModel?.setState(
                                      (state) => state.setTitle(title),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: defaultPadding,),
                          StateBuilder<PlaceFormModel>(
                            observe: () => _singletonPlaceFormModel,
                            builder: (context, placeFormModel) 
                            => TextField(
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Beschreibung",
                              ),
                              onChanged: (description) {
                                placeFormModel?.setState(
                                      (state) => state.setDescription(description),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: defaultPadding * 1.5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CategoryCardWidget(category_id: 'beach', activated: category_id == 'beach', callback: () {
                                setState(() {
                                  category_id = 'beach';
                                });
                              },),
                              CategoryCardWidget(category_id: 'city', activated: category_id == 'city', callback: () {
                                setState(() {
                                  category_id = 'city';
                                });
                              },),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CategoryCardWidget(category_id: 'sight', activated: category_id == 'sight', callback: () {
                                setState(() {
                                  category_id = 'sight';
                                });
                              },),
                              CategoryCardWidget(category_id: 'nature', activated: category_id == 'nature', callback: () {
                                setState(() {
                                  category_id = 'nature';
                                });
                              },),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CategoryCardWidget(category_id: 'adventure', activated: category_id == 'adventure', callback: () {
                                setState(() {
                                  category_id = 'adventure';
                                });
                              },),
                              CategoryCardWidget(category_id: OTHERS, activated: category_id == OTHERS, callback: () {
                                setState(() {
                                  category_id = OTHERS;
                                });
                              },),
                            ],
                          ),
                          SizedBox(height: defaultPadding * 1.5,),
                          (latlngState == null) ? Text(
                              "Wähle deinen Lieblingsort:"
                          ) : SizedBox(height: 0,),
                          SizedBox(height: defaultPadding * 0.3,),
                          StateBuilder<PlaceFormModel>(
                            observe: () => _singletonPlaceFormModel,
                            builder: (context, placeFormModel)
                            => (latlngState == null) ? LocationSelector(
                                latLngCallback: (latlng) {
                                  placeFormModel?.setState(
                                        (state) => state.setLatLng(latlng),
                                  );
                                  setState(() {
                                    latlngState = "Koordinaten festgelegt: \n\n" + latlng.toString();
                                  });
                                }
                            ) : DataLoadingText(text: latlngState!),
                          ),
                          SizedBox(height: defaultPadding * 1.5,),
                          ElevatedButton(
                              onPressed: () {
                                if (!_singletonPlaceFormModel.state.validateData()) {
                                showSnackbar(context: context, message: "Bitte valide Daten einfügen.");
                                } else {
                                  _singletonPlaceFormModel.setState(
                                    (state) async {
                                      placeRef.add(
                                          MyPlace(
                                            title: state.title!,
                                            description: state.description!,
                                            journey_id: widget.relatedJourney.id,
                                            latitude: state.latLng!.latitude,
                                            longitude: state.latLng!.longitude,
                                            category_id: category_id,
                                          )
                                      );
                                    }
                                  );
                                  widget.callback.call();
                                  Navigator.pop(context);
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
                ),
              );
            }
        )
    );
  }
}