import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/model/songs_info.dart';

class MusicModel with ChangeNotifier {
  List<SongInfo> _entity = [];

  List<SongInfo> get entity => _entity;

  SongInfo _currentPlay;
  SongInfo _lastPlay;
  SongInfo _nextPlay;
  AudioPlayer audioPlayer;
  NotificationService notificationService;

  MusicModel() {
    audioPlayer = AudioPlayer(
        mode: PlayerMode.MEDIA_PLAYER, playerId: "sh4lin-music-player");
    audioPlayer.setReleaseMode(ReleaseMode.STOP);
    notificationService = audioPlayer.notificationService;
    _setListeners();
  }

  void _setListeners() {
    audioPlayer.onPlayerCompletion.listen((event) {
      stopAll();
      playNext();
    });
    audioPlayer.onPlayerError.listen((event) {
      print("Audio Player Error $event");
    });
    audioPlayer.onAudioPositionChanged.listen((event) {});
    audioPlayer.onPlayerStateChanged.listen((event) {});
  }

  SongInfo get currentPlay => _currentPlay;

  void changePlayId(SongInfo newPlay) {
    pauseAudio();
    _currentPlay = newPlay;
    _setPrevious();
    _setNext();
    playAudio();
    notifyListeners();
  }

  void _setPrevious() {
    if (checkCurrentPlayNull()) {
      if (_currentPlay.id > 1) {
        _lastPlay = entity[_currentPlay.id - 2];
      } else {
        _lastPlay = entity.last;
      }
    }
  }

  void _setNext() {
    if (checkCurrentPlayNull()) {
      if (_currentPlay.id >= entity.length) {
        _nextPlay = entity[0];
      } else {
        _nextPlay = entity[_currentPlay.id];
      }
    }
  }

  void pauseAudio() async {
    if (checkCurrentPlayNull()) {
      var result = await audioPlayer.pause();
      if (result == 1) {
        _currentPlay.isPlaying = false;
      }
    }
    notifyListeners();
  }

  bool checkCurrentPlayNull() {
    if (_currentPlay != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isAudioPlayerPlaying() {
    if (audioPlayer.state == PlayerState.PLAYING) {
      return true;
    } else {
      return false;
    }
  }

  void playAudio() async {
    if (checkCurrentPlayNull()) {
      var result = await audioPlayer.play(_currentPlay.songPath,
          isLocal: true, stayAwake: true);
      if (result == 1) {
        _currentPlay.isPlaying = true;
      }
    }
    notifyListeners();
  }

  void playNext() {
    changePlayId(_nextPlay);
  }

  void playPrevious(MusicModel model) {
    changePlayId(_lastPlay);
  }

  set entity(List<SongInfo> value) {
    _entity = value;
    notifyListeners();
  }

  void stopAll() {
    pauseAudio();
    _entity.forEach((element) {
      element.isPlaying = false;
    });
    notifyListeners();
  }
}
