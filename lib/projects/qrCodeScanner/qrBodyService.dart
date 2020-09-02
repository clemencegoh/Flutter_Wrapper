import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrGeneratorService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrScannerService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flushbar/flushbar.dart';


class QRService extends StatefulWidget {

  final int currentIndex;

  QRService({
    Key key,
    @required this.currentIndex
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => new QRServiceState();
}

// Chooses between the 3 possible widgets
class QRServiceState extends State<QRService> {
  @override
  void initState() {
    super.initState();
    this.recentVisits = QRScannerServiceState.recentVisits;
  }

  String recentVisits;

  @override
  Widget build(BuildContext context){
    print("Rebuilding...");
    switch (widget.currentIndex){
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

  Widget _getRecentVisits(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> items = [];

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
                      List<String> newList = snapshot.data;
                      newList.removeAt(index);
                      _setRecentToPrefs(newList);
                    });
                  },
                )
              ],
            ),
          )
      );
    }

    return Scaffold( 
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: items,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // remove all
          setState(() {
            _setRecentToPrefs([]); 
          });
        },
        child: Icon(Icons.delete_forever),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }

  Future _getRecentFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(this.recentVisits);
  }

  void _setRecentToPrefs(List<String> recents) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(recentVisits, recents);
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


