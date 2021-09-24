import 'package:flutter_music_player_app/network/repository/link_repository.dart';

class LinkState {
  final LinkReposityImpl _linkRepository;

  LinkState(this._linkRepository);

  Future add({
    String? url,
    String? description
  }) async => await _linkRepository.add(url: url, description: description);

  //Future geAll() async => await _linkRepository.getAll();

}