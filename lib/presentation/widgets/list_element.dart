import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/network/model/category.dart';
import 'package:flutter_music_player_app/network/model/place.dart';


class MyPlaceListElement extends StatelessWidget {
  const MyPlaceListElement({Key? key, required this.place, required this.callback}) : super(key: key);

  final MyPlace place;
  final GestureTapCallback callback;


  @override
  Widget build(BuildContext context) {
    return ListElement(
      title: place.title,
      description: place.description,
      category_id: place.category_id,
      callback: callback,
    );
  }
}


class ListElement extends StatelessWidget {
  const ListElement({
    Key? key,
    required this.title,
    required this.description,
    this.image_url,
    this.icon,
    this.img_size = 100.0,
    this.category_id,
    required this.callback,
    this.showButton = true,
  }) : super(key: key);

  final String title;
  final String description;
  final String? image_url;
  final IconData? icon;
  final double img_size;
  final String? category_id;
  final GestureTapCallback callback;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      (image_url != null) ?
                      ((image_url!.contains("http")) ?
                      Image.network(image_url!, height: img_size, width: img_size,) :
                      Image.asset(image_url!, height: img_size, width: img_size,)) :
                      (icon != null) ? Icon(icon, size: img_size,) :
                      (CATEGORIES()[category_id]?.icon != null) ? Text(CATEGORIES()[category_id]!.icon, style: TextStyle(fontSize: 35.0),) : SizedBox(width: 0,),
                      SizedBox(width: defaultPadding,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          (title != null) ?
                          Text(title, style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito'
                          ),) : SizedBox(width: 0,),
                          SizedBox(height: 5.0,),
                          (description != null) ?
                          Container(
                            width: 190,
                            child: Text(
                              description,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),),
                          ) : SizedBox(width: 0,)
                        ],
                      ),
                    ],
                  ),
                  (showButton) ? Container(
                    // child: Padding(
                    //                       padding: const EdgeInsets.all(8.0),
                    //                       child: Text("Diesen \nOrte\n auswählen"),
                    //                     ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.arrow_forward, color: Colors.black,),
                    ),
                  ): SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}