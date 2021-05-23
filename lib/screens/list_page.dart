import 'package:flutter/material.dart';
import 'package:music_player/core/const.dart';
import 'package:music_player/model/music_model.dart';
import 'package:music_player/screens/details_page.dart';
import 'package:music_player/widget/custom_button.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Consumer<MusicModel>(
                builder: (context, _list, child) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _list.entity.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Material(
                          color: Colors.transparent,
                          elevation: .4,
                          shadowColor: AppColors.lightBlueShadow,
                          animationDuration: Duration(microseconds: 500),
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: "player $index",
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                _list.stopAll();
                                _list.changePlayId(_list.entity[index]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => DetailsPage()));
                              },
                              child: AnimatedContainer(
                                duration: Duration(microseconds: 500),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: _list.checkCurrentPlayNull()
                                        ? _list.entity[index].isPlaying
                                            ? AppColors.activeColor
                                            : AppColors.mainColor
                                        : AppColors.mainColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            runAlignment: WrapAlignment.start,
                                            alignment: WrapAlignment.start,
                                            children: [
                                              Text(
                                                _list.entity[index].songTitle,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: AppColors.styleColor,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          /*Wrap(
                                            runAlignment: WrapAlignment.start,
                                            alignment: WrapAlignment.start,
                                            children: [
                                              Text(
                                                _list.entity[index].songAlbum,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: AppColors.styleColor
                                                        .withAlpha(90),
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: CustomButton(
                                        child: Icon(
                                          _list.checkCurrentPlayNull()
                                              ? _list.entity[index].isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow
                                              : Icons.play_arrow,
                                          color: _list.checkCurrentPlayNull()
                                              ? _list.entity[index].isPlaying
                                                  ? Colors.white
                                                  : AppColors.styleColor
                                              : AppColors.styleColor,
                                        ),
                                        isActive: _list.checkCurrentPlayNull()
                                            ? _list.entity[index].isPlaying
                                            : false,
                                        size: 50,
                                        onTap: () {
                                          if (_list.entity[index].isPlaying) {
                                            print("pause");
                                            _list.pauseAudio();
                                          } else {
                                            _list.stopAll();
                                            _list.changePlayId(
                                                _list.entity[index]);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  AppColors.mainColor.withAlpha(0),
                  AppColors.mainColor
                ])),
          ),
        )
      ],
    );
    var nestedScrollView = NestedScrollView(
      physics: BouncingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 150,
              collapsedHeight: 100,
              backgroundColor: AppColors.mainColor,
              backwardsCompatibility: true,
              forceElevated: false,
              pinned: true,
              flexibleSpace: FittedBox(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.styleColor,
                          ),
                          size: 50,
                          onTap: () {},
                        ),
                        Consumer<MusicModel>(
                          builder: (context, value, child) {
                            return Hero(
                              tag: "player",
                              child: CustomButton(
                                image: "assets/logo.jpg",
                                size: 150,
                                borderWidth: 3,
                                onTap: () {
                                  if (value.currentPlay != null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => DetailsPage()));
                                  }
                                },
                              ),
                            );
                          },
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
                ),
              ))
        ];
      },
      body: stack,
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          backwardsCompatibility: true,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Music Player",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.styleColor,
                fontSize: 16),
          ),
        ),
        backgroundColor: AppColors.mainColor,
        body: Consumer<MusicModel>(
          builder: (context, value, child) {
            if (value.checkCurrentPlayNull()) {
              value.isAudioPlayerPlaying();
              return nestedScrollView;
            } else {
              value.isAudioPlayerPlaying();
              return stack;
            }
          },
        ));
  }
}
