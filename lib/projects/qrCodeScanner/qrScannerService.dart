import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QRScannerService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new QRScannerServiceState();
}

class QRScannerServiceState extends State<QRScannerService> {
  String barcode = 'Scan something to display the link here!';
  bool dialVisible = true;
  static final String recentVisits = 'clem_QR_recent_visits';

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
        alignment: Alignment(0.0, 0.0),  // center alignment

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(8.0),

            child: ListTile(
              title: Text(
                this.barcode,
                textAlign: TextAlign.center,
              ),

              onTap: (){
                this._copyBarcodeMessageToClipboard();
                this._showFlushbar(context, "Message copied to clipboard!");
              },
              onLongPress: (){
                String attemptedURL = this.barcode;
                // render all to lower case
                attemptedURL = attemptedURL.toLowerCase();

                // intelligently guess what to do
                if (!_checkIfURL(attemptedURL)){
                  String builtQuery = "https://www.google.com/search?q=" + attemptedURL;
                  _saveURLToPrefs(builtQuery);
                  this._launchNativeBrowser(builtQuery);
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: _speedDialFAB(),
    );
  }

  bool _checkIfURL(String barcodeRes){
    // checks if the barcode Res is meant to be a URL

    // typically, single length tends to be URLs
    List<String> parsed = barcodeRes.split(" ");
    if (parsed.length == 1){
      // open as URL
      String urlString = parsed[0];
      if (!urlString.startsWith('http')){
        if (!urlString.startsWith('www.')){ urlString = "www." + urlString; }
        urlString = "https://" + urlString;
      }
      this._saveURLToPrefs(urlString);
      this._launchNativeBrowser(urlString);
      return true;
    }
    return false;
  }

  void _saveURLToPrefs(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentList = prefs.getStringList(recentVisits);
    currentList.add(url);
    prefs.setStringList(recentVisits, currentList);
  }

  // Note: This method is only for mobile
  // Launches native browser, allowing user to choose
  void _launchNativeBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      this._showFlushbar(
        context,
        "Could not launch $url",
      );
    }
  }

  void _copyBarcodeMessageToClipboard(){
    Clipboard.setData(new ClipboardData(text: this.barcode));
  }

  void _showFlushbar(BuildContext context, String message){
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
    )..show(context);
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

