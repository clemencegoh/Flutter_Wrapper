import 'package:flutter/material.dart';

ThemeData lunchPredictorTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigoAccent,
    accentColor: Colors.lightBlue,

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
  );
}