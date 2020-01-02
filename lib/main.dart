import 'package:flutter/material.dart';
import 'package:flutter_app/projects/homepage/homepageController.dart';
import 'package:flutter_app/projects/lunchPredictor/lunchPredictorController.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrController.dart';
import 'package:flutter_app/projects/simpleWebview/webView.dart';


void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => new HomePage(),
        '/lunchPredictor': (context) => new LunchPredictorMain(),
        '/webview': (context) => new WebViewLoadingState(),
        '/qrCodeScanner': (context) => new QrCodeScannerController(),
      },
      debugShowCheckedModeBanner: false,
    )
  );
}

