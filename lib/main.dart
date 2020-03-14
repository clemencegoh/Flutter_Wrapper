import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/projects/homepage/homepageController.dart';
import 'package:flutter_app/projects/loginPage/loginScreen.dart';
import 'package:flutter_app/projects/lunchPredictor/lunchPredictorController.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrController.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        homeRoute: (context) => new HomePage(),
        lunchPredictionRoute: (context) => new LunchPredictorMain(),
        qrScannerRoute: (context) => new QrCodeScannerController(),
        loginRoute: (context) => new LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    )
  );
}

