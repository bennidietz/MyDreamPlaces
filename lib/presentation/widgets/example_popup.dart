import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:flutter_music_player_app/network/model/place.dart';
import 'package:flutter_music_player_app/presentation/widgets/place_dialog.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ExamplePopup extends StatefulWidget {
  final Marker marker;
  final MyPlace myPlace;

  ExamplePopup(this.marker, this.myPlace, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Text(
                CATEGORIES()[widget.myPlace.category]?.icon ??
                    CATEGORIES()[OTHERS]!.icon,
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
            _cardDescription(context, widget.myPlace),
            IconButton(
                icon: Icon(Icons.navigation_outlined),
                onPressed: () => MapsLauncher.launchCoordinates(
                    widget.myPlace.latitude, widget.myPlace.longitude))
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context, MyPlace place) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              place.name ?? 'Unbekannter Ort',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              'von ${place.from!}',
              style:
                  const TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Container(
              width: 150,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => PlaceDialog(
                      place: widget.myPlace,
                    ),
                  );
                },
                child: Text('Mehr Details'),
              ),
              // child: Text(
              //   place.description,
              //   style: const TextStyle(fontSize: 14.0),
              //   overflow: TextOverflow.ellipsis,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
