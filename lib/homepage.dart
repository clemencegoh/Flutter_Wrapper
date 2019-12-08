import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/appbar.dart' as appbar;


// Homepage
class HomePage extends StatefulWidget {

  HomePage({Key key}): super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}


// State of homepage
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // Note that setState() when called will rebuild
    return Scaffold(
      appBar: appbar.commonAppbar(context, "Clemence's App"),
      body: overallContainer(),
    );
  }

  // todo: Populate this with other side projects
  Container overallContainer() {
    return Container(
//      margin: const EdgeInsets.only(),
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[

              // Lunch Place Predictor App
              _sideProject(
                  'Lunch Place Predictor',
                  "Submit current location or guess where you'll be having lunch today!",
                  "/lunchPredictor",
                  Icons.not_listed_location,
              ),

            ],
          )
        ],
      ),
    );
  }


  /*

   Creates individual cards as a route for each side project

   */
  Card _sideProject(String name, String description, String route, IconData iconData){
    var currentSize = MediaQuery.of(context).size;

    return Card(
      child: InkWell(
        splashColor: Theme.of(context).splashColor,

        onTap: (){
          print("Navigating to $route");
        Navigator.of(context).pushReplacementNamed(route);
        },

        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Icon + Name
              Container(
                constraints: BoxConstraints(
                  maxWidth: currentSize.width/5,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(iconData),
                      Center(
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ]
                  ),
              ),

              // Description of project
              Flexible(
                child: new Text(description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
