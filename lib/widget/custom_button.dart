import 'package:flutter/material.dart';
import 'package:music_player/core/const.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key,
      @required this.child,
      @required this.size,
      this.image,
      this.onTap,
      this.isActive = false,
      this.borderWidth = 2})
      : super(key: key);

  final Widget child;
  final double size;
  final String image;
  final double borderWidth;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(5, 5),
              spreadRadius: 5),
          BoxShadow(
              color: Colors.white60,
              blurRadius: 5,
              offset: Offset(-5, -5),
              spreadRadius: 5),
        ],
        border: Border.all(
            width: borderWidth,
            color: isActive ? AppColors.darkBlue : AppColors.mainColor));

    if (image != null) {
      boxDecoration = boxDecoration.copyWith(
          image: DecorationImage(
              image: ExactAssetImage(image), fit: BoxFit.cover));
    }

    if (isActive) {
      boxDecoration = boxDecoration.copyWith(
          gradient: RadialGradient(colors: [
        AppColors.lightBlue,
        AppColors.darkBlue,
      ]));
    } else {
      boxDecoration = boxDecoration.copyWith(
          gradient: RadialGradient(colors: [
        AppColors.mainColor,
        AppColors.mainColor,
        AppColors.mainColor,
        Colors.white
      ]));
    }

    return Center(
      child: Container(
          height: size,
          width: size,
          decoration: boxDecoration,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: child,
              borderRadius: BorderRadius.circular(200),
              onTap: onTap,
            ),
          )),
    );
  }
}
