import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/appbar.dart' as appbar;

import 'package:flutter_app/BLoC/login.dart' as loginBLoC;


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
          appbar.functionalIcon(Icons.person_pin, loginBLoC.login),
        ],
      ),
    );
  }

  void _openDrawer(){
    // todo: Implement
    print("Hello, opening drawer!");
  }

  Widget _wrapperBody(){
    return Stack(
      children: <Widget>[
        _backgroundGradient(),
        _bodyCardsArea(),
      ],
    );
  }

  // Contains Motivation Card and project cards
  Widget _bodyCardsArea(){
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: <Widget>[
          _buildMotivationalCard(),
          _projectsContentArea(),
        ],
      ),
    );
  }


  Widget _buildMotivationalCard(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _motivationalImageBuilder(),
          _quoteOfTheDayBuilder(),
        ],
      ),
    );
  }

  Widget _motivationalImageBuilder(){
    // todo: Implement dynamic build logic here

    return Center(
      child: Container(
        padding: EdgeInsets.only(
          top: 12.0,
          left: 12.0,
          right: 12.0,
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset("assets/images/darker-rain.jpg"),
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
            ),
          ]
        ),
      ),
    );
  }

  Widget _quoteOfTheDayBuilder(){
    // todo: Implement logic to get quote dynamically

    return ListTile(
      leading: Icon(
        Icons.format_quote,
        size: 30,
      ),
      title: Text("If you cannot do great things, do small things in a great way."),
      subtitle: Text("Napolean Hill"),
    );
  }

  Widget _projectsContentArea(){
    return Container(
      child: new Expanded(
        child: new ListView(
          shrinkWrap: true,
          children: _getAllProjects(),
        )
      )
    );
  }


  List<Widget> _getAllProjects(){
    // todo: Implement logic to get all projects

    return <Widget>[
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),

          child: ListTile(
            leading: Icon(
              Icons.not_listed_location,
              size: 38,
            ),
            title: Text("Location Prediction"),
            subtitle: Text("Submit current location or guess where you'll be having lunch today!"),
            trailing: Icon(Icons.navigate_next),
            onTap: (){ print("Navigating!!"); },
          ),
        ),
      ),
    ];
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
}
