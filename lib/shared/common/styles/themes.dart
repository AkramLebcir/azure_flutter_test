import 'package:flutter/material.dart';

import '../common.dart';

class Themes {
  // App Theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    backgroundColor: ColorPalettes.lightBG,
    primaryColor: ColorPalettes.grey,
    accentColor: ColorPalettes.lightAccent,
    cursorColor: ColorPalettes.lightAccent,
    dividerColor: ColorPalettes.darkBG,
    scaffoldBackgroundColor: ColorPalettes.lightBG,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorPalettes.lightPrimary,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: ColorPalettes.lightPrimary,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    backgroundColor: ColorPalettes.darkBG,
    primaryColor: ColorPalettes.darkPrimary,
    accentColor: ColorPalettes.darkAccent,
    dividerColor: ColorPalettes.lightPrimary,
    scaffoldBackgroundColor: ColorPalettes.darkBG,
    cursorColor: ColorPalettes.darkAccent,
    appBarTheme: AppBarTheme(
      color: ColorPalettes.darkPrimary,
      // backgroundColor: ColorPalettes.darkBG,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: ColorPalettes.lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  // Text Theme
  static TextStyle textStyleHeader1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: ColorPalettes.blackP,
    fontFamily: 'Roboto',
  );
  static TextStyle textStyleHeader2 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: ColorPalettes.blackP,
      fontFamily: 'Roboto');
  static TextStyle textStyleHeader3 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: ColorPalettes.blackP,
      fontFamily: 'Roboto');
  static TextStyle textStyleHeaderColor = TextStyle(
      fontSize: 14, color: ColorPalettes.lightAccent, fontFamily: 'Roboto');

  static TextStyle textStyleHeaderColorWhite =
      TextStyle(fontSize: 14, color: ColorPalettes.white, fontFamily: 'Roboto');
  static TextStyle textStyleP = TextStyle(
      fontSize: 12, color: ColorPalettes.blackP, fontFamily: 'Roboto');

  static TextStyle textStyleContent = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: const Color(0xff707070),
    fontWeight: FontWeight.w500,
    height: 0.6875,
  );

  static TextStyle textStyleContentP = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: const Color(0xff707070),
    fontWeight: FontWeight.w500,
  );

  static BorderRadius borderRadius5 = BorderRadius.all(Radius.circular(5));

  static BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));

  static Decoration borderDecoration = BoxDecoration(
      borderRadius: borderRadius5,
      border: Border.all(color: ColorPalettes.lightAccent));

  static BoxDecoration boxDecorationGrey = BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: const Color(0xffefefef),
  );

  static BoxDecoration boxDecorationcard = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    color: const Color(0xffffffff),
    border: Border.all(width: 0.5, color: const Color(0xff459d9c)),
  );

  static BoxDecoration boxDecorationcard_offre = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: const Color(0xffffffff),
    boxShadow: [
      BoxShadow(
        color: const Color(0x29aaaaaa),
        offset: Offset(0, 3),
        blurRadius: 6,
      ),
    ],
  );
//------------------------------- step0

  static TextStyle textInputeStyleTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: const Color(0xff1d1e1e),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textInputeStyleContent2 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    color: const Color(0xff707070),
    fontWeight: FontWeight.w500,
  );

  static TextStyle textInputeStyleContentBolder = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: const Color(0xff1d1e1e),
    fontWeight: FontWeight.w900,
  );

  static TextStyle textInputeStyleContentStep2 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: const Color(0xff1d1e1e),
  );

  static TextStyle textDatePolicy = TextStyle(
    fontFamily: 'Lato',
    fontSize: 32,
    color: const Color(0xde459d9c),
    fontWeight: FontWeight.w900,
  );
}
