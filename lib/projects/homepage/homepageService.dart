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
        left: 8,
        right: 8,
      ),
      child: ListView(
        children: [_buildMotivationalCard()] + _getAllProjects(context),
      ),
    );
  }


  Widget _buildMotivationalCard(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
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
          top: 8.0,
          left: 8.0,
          right: 8.0,
        ),
        child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset("assets/images/darker-rain.jpg"),
              ),

              Container(
                padding: EdgeInsets.only(
                  top: 64.0,
                ),
                child: Center(
                  // todo: replace this when login implemented
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
    String quoteOfTheDay = "If you cannot do great things, do small things in a great way.";
    String authorOfQuote = "Napolean Hill";

    return FutureBuilder(
      future: QuoteClass().getQuoteOfTheDay(),
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData){
          // catch for error for chrome dev
          if (snapshot.data.author != "Error"){
            quoteOfTheDay = snapshot.data.quote;
            authorOfQuote = snapshot.data.author;
          }
        }else{
          if (snapshot.hasError){
            print(snapshot.error);
          }
        }

        return ListTile(
          title: Text("$quoteOfTheDay"),
          subtitle: Text("$authorOfQuote"),
        );
      },
    );
  }

  List<Widget> _getAllProjects(BuildContext context){
    ProjectsData data = ProjectsData();

    var projectWidgets = <Widget>[];
    for (Project proj in data.getAllData()){
      projectWidgets.add(
        new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),

            child: ListTile(
              leading: Icon(
                proj.icon,
                size: 32,
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