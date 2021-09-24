import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/model/category.dart';

class CategoryCardWidget extends StatefulWidget {
  const CategoryCardWidget({Key? key, required this.category_id, this.activated = false, required this.callback}) : super(key: key);

  final String category_id;
  final bool activated;
  final Function callback;

  @override
  _CategoryCardWidgetState createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    MyCategoryValues myCategoryValues = CATEGORIES()[widget.category_id]
        ?? CATEGORIES()[OTHERS]!;
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => widget.callback.call(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  myCategoryValues.icon,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: (widget.activated) ? Colors.black : Colors.black.withOpacity(0.4),
                  ),
                ),
                SizedBox(width: 12.0,),
                Text(myCategoryValues.name,
                  style:
                  TextStyle(
                    fontSize: (myCategoryValues.name.length > 5) ? 11.0 : 12.0,
                    color: (widget.activated) ? Colors.black : Colors.black.withOpacity(0.4),
                    fontWeight: (widget.activated) ? FontWeight.w600 : FontWeight.w400,
                ),),
              ],
            ),
          )
      ),
    );
  }
}
