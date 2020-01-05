import 'package:flutter/material.dart';
import 'package:flutter_app/projects/homepage/homepageController.dart';
import 'package:flutter_app/projects/lunchPredictor/lunchPredictorController.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrController.dart';
import 'package:flutter_app/projects/simpleWebview/webView.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => new HomePage(),
        LunchPredictorMain.routeName: (context) => new LunchPredictorMain(),
        SimpleWebView.routeName: (context) => new SimpleWebView(),
        QrCodeScannerController.routeName: (context) => new QrCodeScannerController(),
      },
      debugShowCheckedModeBanner: false,
    )
  );
}

