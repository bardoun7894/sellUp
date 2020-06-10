import 'package:flutter/material.dart';

ThemeData mainTheme =ThemeData(
  primaryColorDark: Colors.blue[400],
  accentColor: Color(0xFFCFE8EF),
  cursorColor: Color(0xFF2FA4BD),
  primaryColorLight: Color(0xffEDEDED),

  //accentColor:  Color(0xFF636363),
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