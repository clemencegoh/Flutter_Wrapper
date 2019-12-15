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
    return new Scaffold(
      appBar: appbar.commonAppbar(context, "Lunchplace Predictor"),
      body: _appBody(context),
      floatingActionButton: addNewDatapoint(context),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  FloatingActionButton addNewDatapoint(BuildContext context){
    return FloatingActionButton.extended(
      onPressed: (){

      },
      icon: Icon(Icons.add_location),
      label: Text("Add Datapoint",),
      backgroundColor: const Color(0xff71BDB8),
    );
  }

  Widget _appBody(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 20
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              service.introContainer(),
              service.visitsGraph(),
              service.guessMyLunchPlaceToday(context),
            ],
          ),
        ),
      ),
    );
  }

  // Form field
  Container _submitLocationForm(BuildContext context, TextEditingController controller){

    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
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
              decoration: InputDecoration(
                labelText: "Enter a location",
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.green),
                )
              ),
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