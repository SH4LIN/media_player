import 'package:flutter/cupertino.dart';
import 'package:music_player/model/songs_info.dart';

class MusicModel with ChangeNotifier {
  List<SongInfo> _entity = [];

  List<SongInfo> get entity => _entity;

  set entity(List<SongInfo> value) {
    _entity = value;
    notifyListeners();
  }

  void stopAll() {
    _entity.forEach((element) {
      element.isPlaying = false;
    });
    notifyListeners();
  }
}
