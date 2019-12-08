import 'package:flutter/material.dart';


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
    // todo: Note that setState() when called will rebuild
    return Container(
        child: new Scaffold(
          appBar: commonAppbar(context),
          body: overallContainer(),
        )
    );
  }


  // build appbar
  AppBar commonAppbar(BuildContext context) {
    return new AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _commonAppBarIcon(Icons.home, context),
          Text('Clemence\'s App'),
          _commonAppBarIcon(Icons.person_pin, context), // Should be logged in
        ],
      ),
    );
  }

  IconButton _commonAppBarIcon(IconData iconData, BuildContext context){
    if (iconData == Icons.person_pin){
      return IconButton(
        icon: Icon(iconData),
        onPressed: (){
          // Do nothing here for now
          print('Trying to log in?');
        },
      );
    }
    if (iconData == Icons.home){
      return IconButton(
        icon: Icon(iconData),
        onPressed: (){
          print('Trying to go home!');
          Navigator.of(context).pushNamed('/');
        },
      );
    }
    // This shouldn't happen
    return IconButton(
      icon: Icon(Icons.device_unknown),
      onPressed: (){
        print("This was never supposed to happen, developer!");
      },
    );
  }

  // body to contain all links to side projects
  Container overallContainer() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // first side project
        children: <Widget>[
          _sideProject(
            'Lunch Place Predictor',
            "Submit current location or guess where you\'ll be having lunch today!",
            "/lunchPredictor",
            Icons.not_listed_location,
          )
        ],
      ),
    );
  }

  GestureDetector _sideProject(String name, String description,
      String route, IconData iconData){

    return GestureDetector(
      onTap: (){
        print("Navigating to $route");
//        Navigator.of(context).pushNamed(route);
      },
      onLongPress: (){
        print("Long press detected!");
        showDialog(
            context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text("More info"),
                content: new Text("$description"),
              );
            }
        );

      },
      child: new Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(iconData),
              Text(name),
            ],
          )
      ),
    );
  }
}
