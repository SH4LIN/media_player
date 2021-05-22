import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/music_model.dart';
import 'package:music_player/model/songs_info.dart';

class CurrentPlaying with ChangeNotifier {
  SongInfo _currentPlay;
  AudioPlayer _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  SongInfo get currentPlay => _currentPlay;

  void changePlayId(SongInfo newPlay) {
    if (_currentPlay != null) {
      pauseAudio();
    }
    _currentPlay = newPlay;
    playAudio();
    notifyListeners();
  }

  void pauseAudio() async {
    var result = await _audioPlayer.pause();
    if (result == 1) {
      _currentPlay.isPlaying = false;
    }
    notifyListeners();
  }

  void playAudio() async {
    var result = await _audioPlayer.play(_currentPlay.songPath,
        isLocal: true, stayAwake: true);
    if (result == 1) {
      _currentPlay.isPlaying = true;
    }
    notifyListeners();
  }

  void playNext(MusicModel model) {
    changePlayId(model.entity[_currentPlay.id]);
  }

  void playPrevious(MusicModel model) {
    changePlayId(model.entity[_currentPlay.id - 2]);
  }

  void setAudioPlayerEventListener(MusicModel model) {
    _audioPlayer.onPlayerCompletion.listen((event) {
      model.stopAll();
      playNext(model);
    });
  }
}
