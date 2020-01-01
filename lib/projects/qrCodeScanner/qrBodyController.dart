import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrGeneratorController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_app/projects/qrCodeScanner/qrScannerService.dart';



// Chooses between the 3 possible widgets
class QRService {

  QRService(BuildContext buildContext){
    this.context = buildContext;
  }

  BuildContext context;
  String recentVisits = 'QR_recent_visits';

  Widget getWidget(int choice){
    switch (choice){
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

  Widget _getRecentVisits(BuildContext context, AsyncSnapshot snapshot){
    List<Widget> items = [
      Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Hello world"),
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


    if (snapshot.hasData){
      items = [];  // replace placeholder
      for (String data in snapshot.data){
        items.add(
          Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text(data),
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
// todo: implement
//            dismissal: SlidableDismissal(
//              child: SlidableDrawerDismissal(),
//              onDismissed: (actionType) {
//                _showSnackBar(
//                    context,
//                    actionType == SlideActionType.primary
//                        ? 'Dismiss Archive'
//                        : 'Dimiss Delete');
//                setState(() {
//                  items.removeAt(index);
//                });
//              },
//            ),
          ),
        );
      }
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
    return new QRBarcodeScanner();
  }

  Widget _generateNewPage(){
    return new QRGenerator();
  }
}


