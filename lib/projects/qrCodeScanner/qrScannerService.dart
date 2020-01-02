import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';



class QRBarcodeScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _QrScannerState();
}

class _QrScannerState extends State<QRBarcodeScanner> {
  String barcode = 'Scan something to display the link here!';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Center(
          child: Text(this.barcode),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.indigoAccent,
        onPressed: scan,
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      // don't do anything
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}