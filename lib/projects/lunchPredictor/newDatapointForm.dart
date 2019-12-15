import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SubmitNewDatapoint {

  Widget datapointFormContainer(BuildContext context, GlobalKey<FormState> formKey) {
    return AlertDialog(
      title: Text("Submit new location"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height/3,
        child: Form(
          key: formKey,
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Enter Location"
                ),
                validator: (value){
                  if (value.isEmpty){
                    return "Location cannot be empty";
                  }
                  return null;
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: RaisedButton(
                  child: Text("Submit"),
                  onPressed: (){
                    trySubmitting(context, formKey);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void trySubmitting(BuildContext context, GlobalKey<FormState> formKey){
    if (formKey.currentState.validate()){
      Response attempt = postNewDatapoint();
      if (attempt.statusCode == 200){
        Flushbar(
//          title: "Data sent!",
          message: "Data sent!",
          icon: Icon(
            Icons.info_outline,
            size: 28,
            color: Colors.green,
          ),
          leftBarIndicatorColor: Colors.green,
          duration: Duration(seconds: 3),
        )..show(context);

      }else{
        int failedCode = attempt.statusCode;
        Flushbar(
          message: "Failed with code $failedCode",
          icon: Icon(
            Icons.info_outline,
            size: 28,
            color: Colors.redAccent,
          ),
          leftBarIndicatorColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    }
  }

  Response postNewDatapoint(){
    return Response("Yes", 200);
  }

}