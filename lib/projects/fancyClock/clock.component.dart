import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class ClockComponent extends StatefulWidget {
  ClockComponent({Key key}) : super(key: key);

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  @override
  _ClockState createState() => _ClockState();
}

// Simple login screen
class _ClockState extends State<ClockComponent> with SingleTickerProviderStateMixin {

  AnimationController animationController;

  @override
  void initState(){
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      upperBound: pi * 2,   // 360 degrees
      lowerBound: 0,
      duration: new Duration(seconds: 8),
    );

    animationController.forward(from: 0.0);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            soothingLogo(),
          ],
        ),
      ),
    );
  }

  Widget soothingLogo(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Stack(
        children: <Widget>[
          genericLogo(),  
          // animatedCircularProgress(),   
        ]
      ),
    );
  }

  Widget genericLogo(){

    // double desiredSize =  MediaQuery.of(context).size.width - 48;
    double desiredSize = 300;

    return Center(
      child: Container(
        height: desiredSize,
        width: desiredSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/eclipse_wallpaper.png'),
          ),
        ),
      ),
    );
  }

  Widget animatedCircularProgress(){
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: new AnimatedBuilder(
        animation: animationController,
        child: circularProgress(),
        builder: (BuildContext context, Widget _widget) {
          return new Transform.rotate(
            angle: animationController.value,
            child: _widget,
          );
        },
      ),
    );
  }

  double currentProgress = 40;
  String currentLabel = '';

  Widget circularProgress(){
    return Container(
      child: AnimatedCircularChart(
        key: widget._chartKey,
        size: Size(
          MediaQuery.of(context).size.width - 48,
          MediaQuery.of(context).size.width - 48   
        ), 
        initialChartData: <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry(
                currentProgress,
                Colors.blue[400],
                rankKey: 'completed',
              ),
            ],
            rankKey: 'progress',
          ),
        ],

        chartType: CircularChartType.Radial,
        percentageValues: true,
        edgeStyle: SegmentEdgeStyle.round,
      ),
    );
  }

}