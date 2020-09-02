import 'package:flutter/material.dart';
import 'package:flutter_app/projects/experimental/animation/rotatingProgress.dart';


class ExperimentsScreen extends StatefulWidget {
  ExperimentsScreen({Key key}) : super(key: key);

  @override
  _ExperimentScreenState createState() => _ExperimentScreenState();
}

class _ExperimentScreenState extends State<ExperimentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _simpleAppbar("Experiments"),
      body: _bodyContainer(),
    );
  }

  Widget _bodyContainer(){
    return Container(
      child: RotatingProgress(),
    );
  }

  AppBar _simpleAppbar(String title){
    return AppBar(
      elevation: 0,
      title: Text(title),
    );
  }

}