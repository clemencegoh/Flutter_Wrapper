import 'package:flutter/material.dart';

ThemeData lunchPredictorTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff59AEFF),
    accentColor: const Color(0xff6966FF),
    splashColor: const Color(0xff5176E8),

    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.black87
    ),



    fontFamily: 'Montserrat',

    textTheme: _lunchPredictorTextTheme(),
  );
}


TextTheme _lunchPredictorTextTheme(){
  return TextTheme(
    headline: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold
    ),

    title: TextStyle(
      fontSize: 36.0,
      fontStyle: FontStyle.italic
    ),

    body1: TextStyle(
      fontSize: 14.0,
    ),

    button: TextStyle(
      fontWeight: FontWeight.bold,
    )
  );
}