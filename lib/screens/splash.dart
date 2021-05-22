import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/const.dart';
import 'package:music_player/model/music_model.dart';
import 'package:music_player/model/songs_info.dart';
import 'package:music_player/screens/list_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<SongInfo> _songs = [];
  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
          child: Container(
        child: CircularProgressIndicator(),
      )),
    );
  }

  Future<void> checkPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted) {
        _files();
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ListPage())));
      } else {
        var statusExternalStorage = await Permission.storage.request();
        if (statusExternalStorage.isGranted) {
          _files();
          Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ListPage())));
        }
      }
    } else if (Platform.isIOS) {
    } else if (Platform.isWindows) {
    } else if (Platform.isFuchsia) {
    } else if (Platform.isLinux) {
    } else if (Platform.isMacOS) {}
  }

  Future<void> _files() async {
    if (Platform.isAndroid) {
      Directory dir1 = Directory(
          '${Platform.pathSeparator}storage${Platform.pathSeparator}emulated${Platform.pathSeparator}0${Platform.pathSeparator}');
      Directory dir2 = Directory(
          '${Platform.pathSeparator}storage${Platform.pathSeparator}446E-15FD${Platform.pathSeparator}');

      recursive(dir1);
      if (dir2.existsSync()) {
        recursive(dir2);
      }
      if (_songs.isNotEmpty) {
        Provider.of<MusicModel>(context, listen: false).entity = _songs;
      }
    } else if (Platform.isIOS) {
    } else if (Platform.isWindows) {
    } else if (Platform.isFuchsia) {
    } else if (Platform.isLinux) {
    } else if (Platform.isMacOS) {}
  }

  int id = 1;

  void recursive(Directory d) {
    bool flag = false;
    List<FileSystemEntity> tempEntity = d.listSync();
    tempEntity.forEach((element) {
      if (element.statSync().type == FileSystemEntityType.directory) {
        flag = true;
        Directory d = new Directory(element.path);
        recursive(d);
      } else if (element.statSync().type == FileSystemEntityType.file) {
        if (element.path.endsWith("mp3")) {
          FileStat tempStat = element.statSync();
          if (tempStat.size > 1000000) {
            _songs.add(SongInfo(
                id,
                element,
                tempStat.size,
                element.path,
                element.uri,
                "${tempStat.size}",
                element.path
                    .split(Platform.pathSeparator)
                    .last
                    .split(".")
                    .first));
            id++;
          }
        }
      }
      if (!flag) {
        return;
      }
    });
  }
}
