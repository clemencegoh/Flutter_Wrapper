import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/seriesModels.dart';
import 'package:flutter_app/helpers/visitorChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LunchPredictorService{

  Widget graph() {
    final normalColor = charts.ColorUtil.fromDartColor(Colors.blue);

    final data = [
      VisitorSeries(
        location: "Simpang Bedok",
        visits: 12,
        barColor: normalColor,
      ),

      VisitorSeries(
        location: "Asia square",
        visits: 2,
        barColor: normalColor,
      ),

      VisitorSeries(
        location: "Chinatown",
        visits: 3,
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



