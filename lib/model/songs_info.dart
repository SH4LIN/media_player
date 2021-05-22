import 'dart:io';

class SongInfo {
  int _id;
  FileSystemEntity _entity;
  String _songTitle;
  String _songAlbum;
  int _songSize;
  String _songPath;
  Uri _songUri;
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  SongInfo(this._id, this._entity, this._songSize, this._songPath,
      this._songUri, this._songAlbum, this._songTitle);

  FileSystemEntity get entity => _entity;

  set entity(FileSystemEntity value) {
    _entity = value;
  }

  String get songTitle => _songTitle;

  set songTitle(String value) {
    _songTitle = value;
  }

  int get songSize => _songSize;

  set songSize(int value) {
    _songSize = value;
  }

  Uri get songUri => _songUri;

  set songUri(Uri value) {
    _songUri = value;
  }

  String get songPath => _songPath;

  set songPath(String value) {
    _songPath = value;
  }

  String get songAlbum => _songAlbum;

  set songAlbum(String value) {
    _songAlbum = value;
  }
}
