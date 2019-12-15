import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';


class VisitorSeries {
  final String location;
  final int visits;
  final charts.Color barColor;

  VisitorSeries(
      {@required this.location,
        @required this.visits,
        @required this.barColor});
}