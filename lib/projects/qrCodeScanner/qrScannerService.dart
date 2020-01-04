import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_tools/qr_code_tools.dart';



class QRBarcodeScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _QrScannerState();
}

class _QrScannerState extends State<QRBarcodeScanner> {
  String barcode = 'Scan something to display the link here!';
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();

  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
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
      floatingActionButton: _speedDialFAB(),
    );
  }

  SpeedDial _speedDialFAB(){
    return SpeedDial(
      marginRight: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: (){},
      onClose: (){},
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        // Scan using camera
        SpeedDialChild(
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: const Color(0xff9A92FF),
          onTap: () => scan(),
        ),

        // Scan QR Code from file
        SpeedDialChild(
          child: Icon(Icons.folder, color: Colors.white),
          backgroundColor: const Color(0xff85BDFF),
          onTap: () => scanFromFile(),
        ),
      ],
    );
  }

  Future _getImageFile() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future scanFromFile() async {
    try{
      File imageFile = await _getImageFile();
      String filepath = imageFile.path;

      String data = await QrCodeToolsPlugin.decodeFrom(filepath);
      setState(() {
        this.barcode = data;
      });
    } on PlatformException catch (e){
      // Catch this error for not found data
      setState(() {
        this.barcode = "Did not detect a valid barcode or QR code";
      });
    } on NoSuchMethodError catch (e){
      // Back button pressed, do nothing
      return;
    }

    catch (e) {
      setState(() {
        this.barcode = 'Error caught: $e';
      });
    }
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