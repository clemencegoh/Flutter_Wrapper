import 'package:flutter/material.dart';
import 'package:flutter_app/constants/routes.dart';
import 'package:flutter_app/projects/homepage/homepageService.dart' as hpService;
import 'package:flutter_app/helpers/appbar.dart' as appbar;

// Homepage
class HomePage extends StatefulWidget {

  HomePage({Key key}): super(key: key);

  static const routeName = '/';

  @override
  _HomePageState createState() => new _HomePageState();

}


// State of projects.homepage
class _HomePageState extends State<HomePage> {

  hpService.HomePageService service;

  @override
  Widget build(BuildContext context) {

    this.service = new hpService.HomePageService(context);

    // Note that setState() when called will rebuild
    return MaterialApp(
      title: "Clemence's App",
      home: new Scaffold(
        appBar: wrapperAppBar(context),
        body: wrapperBody(),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
  }

  Widget wrapperAppBar(BuildContext context) {

    Color backgroundColor = const Color(0xff2E4A70);

    return AppBar(
      elevation: 0.0,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            Text("Projects"),
            appbar.functionalIcon(
              Icons.person_pin,
              (){ Navigator.pushNamed(context, loginRoute); }
            ),
          ],
        ),
    );
  }

  Widget wrapperBody(){
    return Stack(
      children: <Widget>[
        service.backgroundGradient(),
        service.bodyCardsArea(),
      ],
    );
  }
}
