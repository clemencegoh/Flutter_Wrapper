import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_app/homepage/projectsRepository.dart';
import 'package:flutter_app/homepage/projectsModel.dart';


class HomePageService {

  HomePageService(BuildContext context){
    this.context = context;
  }

  BuildContext context;

  // Contains Motivation Card and project cards
  Widget bodyCardsArea(){
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 10,
        right: 10,
      ),
      child: Column(
        children: <Widget>[
          _buildMotivationalCard(),
          _projectsContentArea(context),
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
                  top: 60.0,
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

  Widget _projectsContentArea(BuildContext context){
    return Container(
        child: new Expanded(
            child: new ListView(
              shrinkWrap: true,
              children: _getAllProjects(context),
            )
        )
    );
  }


  List<Widget> _getAllProjects(BuildContext context){
    ProjectsData data = ProjectsData();

    var projectWidgets = <Widget>[];
    for (Project proj in data.getAllData()){
      projectWidgets.add(
        new Card(
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
              title: Text(proj.title),
              subtitle: Text(proj.description),
              trailing: Icon(proj.icon),
              onTap: (){
                  Navigator.pushReplacementNamed(context, proj.route);
                },
            ),
          ),
        )
      );
    }

    return projectWidgets;
  }

  Widget backgroundGradient(){
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