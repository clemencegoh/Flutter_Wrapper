import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class RotatingProgress extends StatefulWidget {
  RotatingProgress({Key key}) : super(key: key);

  @override
  _RotatingProgressState createState() => _RotatingProgressState();
}

class _RotatingProgressState extends State<RotatingProgress> {
  @override
  Widget build(BuildContext context) {
    
    final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
    
    
    return Container(
      child: Stack(
        children: [
          Center(
            child: AnimatedCircularChart(
              key: _chartKey,
              initialChartData: <CircularStackEntry>[
                new CircularStackEntry(
                  <CircularSegmentEntry>[
                    new CircularSegmentEntry(
                      10,
                      Colors.blue[400],
                      rankKey: 'completed',
                    ),
                    // new CircularSegmentEntry(
                    //   66.67,
                    //   Colors.blueGrey[600],
                    //   rankKey: 'remaining',
                    // ),
                  ],
                  rankKey: 'progress',
                ),
              ],

              size: const Size(300, 300),
              chartType: CircularChartType.Radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
            )
          ),


        ]
      ),
    );
  }
}