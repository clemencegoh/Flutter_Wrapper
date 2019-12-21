import 'package:flutter/material.dart';
import 'package:flutter_app/BLoC/login.dart' as loginBLoC;


// build appbar
AppBar commonAppbar(BuildContext context, String title) {

  Color backgroundColor = const Color(0xff2E4A70);

  return new AppBar(
    elevation: 0.0,
    backgroundColor: backgroundColor,

    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        functionalIcon(
            Icons.home,
            (){ Navigator.pushReplacementNamed(context, "/"); },
        ),
        Text(title),
        functionalIcon(Icons.person_pin, loginBLoC.login),
      ],
    ),
  );
}

IconButton functionalIcon(IconData iconData, Function logic){
  return IconButton(
    icon: Icon(iconData),
    onPressed: (){ logic(); },
  );
}