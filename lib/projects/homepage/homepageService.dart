import 'package:flutter/material.dart';
import 'package:flutter_app/projects/homepage/dioQuoteGetter.dart';
import 'package:flutter_app/projects/homepage/projectsRepository.dart';
import 'package:flutter_app/projects/homepage/projectsModel.dart';


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
    // todo: find out why this doesn't work
    String quoteOfTheDay = "If you cannot do great things, do small things in a great way.";
    String authorOfQuote = "Napolean Hill";

    return FutureBuilder(
      future: getRandomQuote(),
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData){
          print(snapshot.data);
          quoteOfTheDay = snapshot.data["Quote"];
          authorOfQuote = snapshot.data["Author"];
        }else{
          if (snapshot.hasError){
            print(snapshot.error);
          }
        }

        return ListTile(
          leading: Icon(
            Icons.format_quote,
            size: 30,
          ),
          title: Text("$quoteOfTheDay"),
          subtitle: Text("$authorOfQuote"),
        );
      },
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
                proj.icon,
                size: 38,
              ),
              title: Text(proj.title),
              subtitle: Text(proj.description),
              trailing: Icon(Icons.navigate_next),
              onTap: (){
                  Navigator.pushNamed(context, proj.route);
                },
            ),
          ),
        )
      );
    }

    return projectWidgets;
  }

  Widget backgroundGradient(){
    Color appbarColor = const Color(0xff2E4A70);
    Color bodyColor = const Color(0xffB5D4FF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [appbarColor, bodyColor],
        ),
      ),
    );
  }
}