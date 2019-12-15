import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/seriesModels.dart';




class VisitorChart extends StatelessWidget {

  final List<VisitorSeries> data;

  VisitorChart({@required this.data});

  @override
  Widget build(BuildContext context){
    List<charts.Series<VisitorSeries, String>> series = [
      charts.Series(
        id: "Visits",
        data: data,
        domainFn: (VisitorSeries series, _) => series.location,
        measureFn: (VisitorSeries series, _) => series.visits,
        colorFn: (VisitorSeries series, _) => series.barColor,
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                  "Places visited today by frequency",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}