import 'package:flutter/material.dart';


// build appbar
AppBar commonAppbar(BuildContext context, String title) {
  return new AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
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