import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/appbar.dart' as appbar;
import 'package:flutter_app/projects/lunchPredictor/lunchPredictorService.dart';


// Main UI for interacting with backend
class LunchPredictorMain extends StatefulWidget {
  LunchPredictorMain({Key key}): super(key: key);

  @override
  _LunchPredictorState createState() => new _LunchPredictorState();
}

class _LunchPredictorState extends State<LunchPredictorMain> {

  // Contains a form for submission
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  LunchPredictorService service = new LunchPredictorService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: appbar.commonAppbar(context, "Lunchplace Predictor"),
//      body: _appBody(context),
      body: service.graph(),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  Container _appBody(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _introContainer(),
          _submitLocationForm(context, textController),
        ],
      ),
    );
  }

  // Brief into to app
  Container _introContainer(){
    return Container(
      child:
        Flexible(
          child: Text(
            "Welcome!\n"
                "This app tries to predict your next "
                "lunch location using Machine Learning!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
    );
  }

  // Form field
  Container _submitLocationForm(BuildContext context, TextEditingController controller){

//    var ts = thisStyle.lunchPredictorTheme();

    return Container(
      margin: EdgeInsets.only(
        top: 40.0,
      ),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a location";
                }
                return null;
              },
            ),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
//            buttonColor: ts.primaryColor,

            child: RaisedButton(
              onPressed: (){
                if (_formKey.currentState.validate()){
                  // Execute post here

                  var currentText = controller.text;

                  // todo: Complete this
                  print("Execute post here with $currentText");

                  // Clear string field
                  controller.clear();
                }
              },
              child: Text(
                  "Submit",
//                style: ts.textTheme.button,
              ),
            ),
          )
        ],
      ),
    );
  }

}