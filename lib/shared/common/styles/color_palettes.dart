library color;

import 'package:flutter/material.dart';

class ColorPalettes {
  //Colors for theme
  static Color lightPrimary = Colors.blue;
  static Color darkPrimary = Color(0xff16161C);
  static Color lightAccent = Colors.lightBlueAccent;
  static Color darkAccent = Colors.blueAccent;
  static Color lightBG = Color(0xffF6FCFF); // F8F8F8  F6FCFF
  static Color lightBGwhite = Color(0xffF8F8F8);
  static Color lightBGwhiteBar = Color(0xffF5F5F5);
  static Color darkBG = Color(0xff212121);

  static Color white = Color(0xffffffff);
  static Color whiteSemiTransparent = Colors.white70;
  static Color grey = Colors.grey;
  static Color greyBg = Color(0xfff0f0f0);
  static Color red = Colors.red;
  static Color yellow = Colors.yellow;
  static Color green = Colors.green;
  static Color setActive = Colors.grey[500];
  static Color blueGrey = Colors.blueGrey;
  static Color black = Color(0xFF000000);
  static Color black12 = Colors.black12;
  static Color blackP = Color(0xFF1D1E1E);
  static Color transparent = Color(0x00000000);

  static Color getColorCircleProgress(double s) {
    Color r = ColorPalettes.red;
    if (s > 4.5 && s < 7)
      r = ColorPalettes.yellow;
    else if (s >= 7) r = ColorPalettes.green;
    return r;
  }
}
