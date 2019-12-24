import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/appbar.dart' as appbar;


// Main UI for interacting with backend
class LearningAppMain extends StatefulWidget {
  LearningAppMain({Key key}): super(key: key);

  @override
  _LearningAppState createState() => new _LearningAppState();
}


class _LearningAppState extends State<LearningAppMain> {

  // Contains a form for submission
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appbar.commonAppbar(context, "Learning App"),
      body: new Container(),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

}