import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/const.dart';
import 'package:music_player/model/music_model.dart';
import 'package:music_player/widget/custom_button.dart';
import 'package:music_player/widget/custom_progress.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.styleColor,
                    ),
                    size: 50,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    "PLAYING NOW",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.styleColor,
                        fontSize: 16),
                  ),
                  CustomButton(
                    child: Icon(
                      Icons.menu,
                      color: AppColors.styleColor,
                    ),
                    size: 50,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Hero(
              tag: "player",
              transitionOnUserGestures: true,
              child: CustomButton(
                image: "assets/logo.jpg",
                size: MediaQuery.of(context).size.width * .7,
                borderWidth: 3,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  children: [
                    Consumer<MusicModel>(builder: (context, value, child) {
                      return Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          children: [
                            Text(value.currentPlay.songTitle,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.styleColor,
                                    height: 2,
                                    fontSize: 18)),
                          ],
                        ),
                      );
                    }),
                    /*Consumer<MusicModel>(builder: (context, value, child) {
                      return Text(value.currentPlay.songAlbum,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.styleColor.withAlpha(90),
                              fontSize: 12));
                    }),*/
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomProgressBar(
                  value: 0.1,
                  labelStart: "1:21",
                  labelEnd: "3:46",
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<MusicModel>(builder: (context, value1, child) {
                      return Consumer<MusicModel>(
                          builder: (context, value, child) {
                        return CustomButton(
                          child: Icon(
                            Icons.navigate_before_rounded,
                            color: AppColors.styleColor,
                          ),
                          size: 60,
                          borderWidth: 3,
                          onTap: () {
                            value.stopAll();
                            value1.playPrevious(value);
                          },
                        );
                      });
                    }),
                    Consumer<MusicModel>(
                      builder: (context, value, child) {
                        return CustomButton(
                          child: Icon(
                            value.isAudioPlayerPlaying()
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          borderWidth: 3,
                          size: 60,
                          isActive: true,
                          onTap: () {
                            if (value.isAudioPlayerPlaying()) {
                              value.pauseAudio();
                            } else {
                              value.playAudio();
                            }
                          },
                        );
                      },
                    ),
                    Consumer<MusicModel>(
                      builder: (context, value1, child) {
                        return Consumer<MusicModel>(
                          builder: (context, value, child) {
                            return CustomButton(
                              child: Icon(
                                Icons.navigate_next_rounded,
                                color: AppColors.styleColor,
                              ),
                              borderWidth: 3,
                              size: 60,
                              onTap: () {
                                value.stopAll();
                                value1.playNext();
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
