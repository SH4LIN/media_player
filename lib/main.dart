import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/music_model.dart';
import 'package:music_player/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  AudioPlayer.logEnabled = true;
  runApp(MusicPlayer());
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MusicModel>(create: (context) => MusicModel()),
      ],
      child: MaterialApp(
        title: "Music Player",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen(),
      ),
    );
  }
}
