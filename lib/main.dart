import 'package:flutter/material.dart';
import 'package:flutter_app/homepage/homepageController.dart' as homepage_main;
import 'package:flutter_app/lunchPredictor/theme/style.dart' as lp_style;
import 'package:flutter_app/lunchPredictor/screens/main.dart' as lp_main;




void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => new homepage_main.HomePage(),
        '/lunchPredictor': (context) => new lp_main.LunchPredictorMain(),
      },
    )
  );
}

