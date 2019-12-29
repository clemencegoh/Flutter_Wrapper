import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/seriesModels.dart';
import 'package:flutter_app/helpers/visitorChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/projects/lunchPredictor/newDatapointForm.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LunchPredictorService{

  // Mock return from http call to microservice
  Future<String> predictedLocationResult(){
    // wait function
    return new Future<String>.delayed(
      Duration(seconds: 3),
          () => "<Some Weird Response>",
    );
  }


  FutureBuilder<String> askForResult(BuildContext context){
    return FutureBuilder<String>(
      future: predictedLocationResult(),
      builder: (context, snapshot){ return; },
    );
  }


  void getLunchLocationData(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Predicting..."),
              ],
            ),
          )
        );
      }
    );

    try{
      String res = await askForResult(context).future;
      Navigator.pop(context);
      Alert(
        context: context,
        type: AlertType.info,
        title: res + "!",
        desc: "Was I right? Input a new datapoint to add to accuracy!",
        buttons: [
          DialogButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
        closeFunction: () => {},  // intended to be empty
      ).show();
    } catch (err){
      Navigator.pop(context);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error Encountered",
        desc: err.toString(),
        buttons: [
          DialogButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
        closeFunction: () => {},  // intended to be empty
      ).show();
    }
  }

  Widget guessMyLunchPlaceToday(BuildContext context){
    // todo: integrate with microservice here

    return ButtonTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      minWidth: MediaQuery.of(context).size.width,
      child: new RaisedButton(
        onPressed: () {
          getLunchLocationData(context);
        },
        child: Text(
          "Today I'm having lunch at..."
        ),
      ),
    );
  }

  void showSubmitNewDatapointDialog(BuildContext context, GlobalKey<FormState> formKey){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return SubmitNewDatapoint()
              .datapointFormContainer(context, formKey);
        },
    );
  }

  // brief into to the app
  Widget introContainer(){
    return Container(
      child:
      Flexible(
        child: Text(
          "Welcome!\n"
              "This app scrapes the web for topics you might be interested in",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget visitsGraph() {
    // todo: retrieve data based off top 3 only
    final normalColor = charts.ColorUtil.fromDartColor(Colors.blue);

    final data = [
      VisitorSeries(
        location: "Simpang Bedok",
        visits: 14,
        barColor: normalColor,
      ),

      VisitorSeries(
        location: "Asia square",
        visits: 5,
        barColor: normalColor,
      ),

      VisitorSeries(
        location: "Chinatown",
        visits: 8,
        barColor: normalColor,
      ),
    ];

    return Center(
      child: VisitorChart(
        data: data,
      ),
    );
  }
}



