import 'dart:ui';

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
    return MaterialApp(
      title: "Clemence's App",
      theme: ThemeData.light(),
      home: new Scaffold(
        appBar: _wrapperAppBar(context),
        body: _wrapperBody(),
      ),

//      debugShowCheckedModeBanner: false,
    );
  }


  Widget _wrapperAppBar(BuildContext context) {

    Color background_color = const Color(0xff2E4A70);

    return new AppBar(
      elevation: 0.0,
      backgroundColor: background_color,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          appbar.functionalIcon(Icons.star, _openDrawer),
          Text("Projects"),
          appbar.functionalIcon(Icons.person_pin, _login),
        ],
      ),
    );
  }

  void _openDrawer(){
    // todo: Implement
    print("Hello, opening drawer!");
  }

  void _login(){
    // todo: implement
    print("trying to log in?");
  }

  Widget _wrapperBody(){
    return Stack(
      children: <Widget>[
        _backgroundGradient(),
        _motivationalCardArea(),
//        _projectsContentArea(),
      ],
    );
  }

  Widget _projectsContentArea(){
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.not_listed_location),
            title: Text("Location Prediction"),
            subtitle: Text("Submit current location or guess where you'll be having lunch today!"),
            trailing: Icon(Icons.navigate_next),
          ),
        ),
      ],
    );
  }

  Widget _motivationalCardArea(){
    return Container(
      padding: EdgeInsets.only(
        top: 28,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              "assets/images/darker-rain.jpg",
                              package: "flutter_app"
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 40.0,
                          ),
                          child: Center(
                            child: Text(
                              "Welcome Back\nClemence",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.format_quote,
                    size: 30,
                  ),
                  title: Text("If you cannot do great things, do small things in a great way."),
                  subtitle: Text("Napolean Hill"),
                ),
              ],
            ),
          ),
// todo: figure this out
//          _projectsContentArea(),
        ],
      ),
    );
  }


  Widget _backgroundGradient(){
    Color appbar_color = const Color(0xff2E4A70);
    Color body_color = const Color(0xffB5D4FF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [appbar_color, body_color],
        ),
      ),
    );
  }


  // todo: Populate this with other side projects
  Widget overallContainer() {
    return Container(
      child: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),_sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),
            _sideProject(
              'Lunch Place Predictor',
              "Submit current location or guess where you'll be having lunch today!",
              "/lunchPredictor",
              Icons.not_listed_location,
            ),

          ],
        ),
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
