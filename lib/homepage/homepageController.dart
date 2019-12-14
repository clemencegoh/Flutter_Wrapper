import 'package:flutter/material.dart';
import 'package:flutter_app/homepage/homepageService.dart' as hpService;
import 'package:flutter_app/homepage/projectsModel.dart';

import 'package:flutter_app/helpers/appbar.dart' as appbar;

import 'package:flutter_app/BLoC/login.dart' as loginBLoC;

// Homepage
class HomePage extends StatefulWidget {

  HomePage({Key key}): super(key: key);

  final hpService.HomePageService _service = new hpService.HomePageService();

  @override
  _HomePageState createState() => new _HomePageState.service(_service);

}


// State of homepage
class _HomePageState extends State<HomePage> {

  hpService.HomePageService service;

  _HomePageState.service(hpService.HomePageService service){
    this.service = service;
  }

  @override
  Widget build(BuildContext context) {
    // Note that setState() when called will rebuild
    return MaterialApp(
      title: "Clemence's App",
      home: new Scaffold(
        appBar: wrapperAppBar(context),
        body: wrapperBody(),
        // todo: pass in state containing favourites
        drawer: homepageDrawer(context),
      ),

//      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState(){
    super.initState();
  }

  // todo: replace this with real implementation
  var data = <Widget>[
    ListTile(
      key: ObjectKey("one"),
      leading: Icon(Icons.ac_unit),
      title: Text("Item 1 ??"),
      onTap: (){
        print("this is item 1");
      },
    ),
    ListTile(
      key: ObjectKey("two"),
      leading: Icon(Icons.not_listed_location),
      title: Text("Item 2 ??"),
      onTap: (){
        print("this is item 2");
      },
    ),
    ListTile(
      key: ObjectKey("three"),
      leading: Icon(Icons.add_comment),
      title: Text("Item 3 ??"),
      onTap: (){
        print("this is item 3");
      },
    ),
  ];

  // todo: not working
  void _onReorder(int oldIndex, int newIndex){
    setState(() {
      Widget oldData = data.removeAt(oldIndex);
      data.insert(newIndex, oldData);
    });
  }

  Drawer homepageDrawer(BuildContext context){
    return Drawer(
      child: ReorderableListView(
        padding: EdgeInsets.zero,
        onReorder: _onReorder,
        children: data
//        <Widget>[
//          DrawerHeader(
//            child: Text(
//              "Favourite Projects",
//              textAlign: TextAlign.center,
//            ),
//            decoration: BoxDecoration(
//              color: Colors.white,
//            ),
//          ),
//          )
//        ],
      ),
    );
  }

  Widget wrapperAppBar(BuildContext context) {

    Color background_color = const Color(0xff2E4A70);

    return new AppBar(
      elevation: 0.0,
      backgroundColor: background_color,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
//          appbar.functionalIcon(Icons.view_list, service.openDrawer),
          Text("Projects"),
          appbar.functionalIcon(Icons.person_pin, loginBLoC.login),
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
