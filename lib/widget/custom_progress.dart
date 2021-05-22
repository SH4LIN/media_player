import 'package:flutter/material.dart';
import 'package:music_player/core/const.dart';
import 'package:music_player/widget/custom_button.dart';

class CustomProgressBar extends StatefulWidget {
  final double value;
  final String labelStart;
  final String labelEnd;

  const CustomProgressBar({Key key, this.value, this.labelStart, this.labelEnd})
      : super(key: key);

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      child: Stack(
        children: [
          _mainProgress(width),
          _progressValue(width * widget.value),
          _indicatorButton(width * widget.value),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.labelStart,
                  style: TextStyle(color: AppColors.styleColor),
                ),
                Text(
                  widget.labelEnd,
                  style: TextStyle(color: AppColors.styleColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicatorButton(double width) {
    return Align(
      child: Container(
        height: 40,
        width: width,
        child: Row(
          children: [
            Expanded(child: SizedBox()),
            CustomButton(
              child: Icon(
                Icons.fiber_manual_record,
                size: 20,
                color: AppColors.darkBlue,
              ),
              size: 30,
              onTap: null,
            )
          ],
        ),
      ),
    );
  }

  Widget _mainProgress(double width) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          height: 5,
          width: width,
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              border: Border.all(
                  color: AppColors.styleColor.withAlpha(90), width: .5),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: AppColors.styleColor.withAlpha(90),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1))
              ])),
    );
  }

  Widget _progressValue(double width) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          height: 5,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            border: Border.all(
                color: AppColors.styleColor.withAlpha(90), width: .5),
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }
}
