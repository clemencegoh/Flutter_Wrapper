import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrGeneratorService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrScannerService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flushbar/flushbar.dart';


class QRService extends StatefulWidget {

  int currentIndex;

  QRService(int currentIndex){
    this.currentIndex = currentIndex;
  }

  @override
  State<StatefulWidget> createState() => new QRServiceState(this.currentIndex);
}

// Chooses between the 3 possible widgets
class QRServiceState extends State<QRService> {

  QRServiceState(int currentIndex){
    this.currentIndex = currentIndex;
  }

  @override
  void initState() {
    this.recentVisits = QRScannerServiceState.recentVisits;
  }

  String recentVisits;
  int currentIndex;

  @override
  Widget build(BuildContext context){
    switch (this.currentIndex){
      case 0: return _recentlyVisitedPage();
      case 1: return _startScanPage();
      case 2: return _generateNewPage();
      default: return _recentlyVisitedPage();
    }
  }

  Widget _recentlyVisitedPage() {
    return FutureBuilder(
      future: _getRecentFromSharedPrefs(),
      builder: _getRecentVisits,
    );
  }

  Future _getRecentFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(this.recentVisits);
  }

  void _saveRecentVisits(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> visitItems = prefs.getStringList(this.recentVisits);
    visitItems.add(location);
    prefs.setStringList(this.recentVisits, visitItems);
  }

  Widget _getRecentVisits(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> items = [
      Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.24,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Sample Placeholder"),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: "Go to",
            icon: Icons.navigate_next,
            color: Colors.blueGrey,
            // todo: navigate to browser
            onTap: (){ print("Navigate"); },
          ),
          IconSlideAction(
            caption: "remove",
            color: Colors.red,
            icon: Icons.delete_forever,
            onTap: (){ print('deleting'); },
          )
        ],
      ),
    ];

    if (snapshot.hasData) {
      items = []; // replace placeholder
      snapshot.data.asMap().forEach((index, value) =>
          items.add(
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.24,
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text(value),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: "Go to",
                  icon: Icons.navigate_next,
                  color: Colors.blueGrey,
                  // todo: navigate to browser
                  onTap: () {
                    print("Navigating to $value");
                    this._launchNativeBrowser(value);
                  },
                ),
                IconSlideAction(
                  caption: "remove",
                  color: Colors.red,
                  icon: Icons.delete_forever,
                  onTap: () {
                    print('deleting from $index');
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                )
              ],
            ),
          )
      );
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: items,
        ),
      ),
    );
  }

  Widget _startScanPage(){
    return new QRScannerService();
  }

  Widget _generateNewPage(){
    return new QRGenerator();
  }

  void _launchNativeBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Flushbar(
        message: "Could not launch URL",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}


