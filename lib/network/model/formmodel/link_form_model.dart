import 'package:flutter_music_player_app/network/errors/common_error.dart';
import 'package:flutter_music_player_app/network/state/link_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LinkFormModel {

  final LinkState _linkState = Injector.get<LinkState>();

  String? url;
  String? description;

  void setDescription(String description) {
    if (!validateDescription(description)) throw CommonError(message: "Invalid email");
    this.description = description;
  }

  void setUrl(String url) {
    if (!validateUrl(url)) throw CommonError(message: "Please fill in your first name");
    this.url = url;
  }

  bool validateUrl(String url) => url.length > 6;

  bool validateDescription(String name) => name.length > 4;

  bool validateData() {
    return this.url != null && this.description != null
        && validateUrl(this.url!) && validateDescription(this.description!);
  }

  add() async {
    return await _linkState.add(
        url: this.url,
        description: this.description,
    );
  }

  // getAll() async {
  //   return await _linkState.getAll();
  // }
}