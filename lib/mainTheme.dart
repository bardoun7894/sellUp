import 'package:flutter/material.dart';

ThemeData mainTheme =ThemeData(
  primaryColorDark: Color(0xff2785E2),
  primaryColorLight: Color(0xffEDEDED),
  accentColor:  Color(0xFF636363),
  fontFamily: 'SFPro',
  textTheme: TextTheme(
    title: TextStyle(
        letterSpacing:1.5 ,
        fontWeight:FontWeight.bold,
        color: Color(0xFF636363)
    ),
    subhead: TextStyle(
        fontWeight:FontWeight.bold,
        letterSpacing:1.5
    ),

  ),

);