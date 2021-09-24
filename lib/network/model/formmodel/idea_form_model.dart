import 'package:flutter_music_player_app/network/errors/common_error.dart';
import 'package:flutter_music_player_app/network/state/link_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class IdeaFormModel {

  String? text;
  

  void setText(String text) {
    if (!validateText(text)) throw CommonError(message: "Text darf nicht leer sein");
    this.text = text;
  }

  bool validateText(String text) => text.length > 0;

  bool validateData() {
    return this.text != null && validateText(this.text!);
  }
}