import 'package:flutter/material.dart';
import 'package:flutter_app/homepage/homepageController.dart' as homepage_main;
import 'package:flutter_app/projects/lunchPredictor/lunchPredictorController.dart' as lp_main;




void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => new homepage_main.HomePage(),
        '/projects.lunchPredictor': (context) => new lp_main.LunchPredictorMain(),
      },
    )
  );
}

