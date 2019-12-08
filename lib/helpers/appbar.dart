import 'package:flutter/material.dart';


// build appbar
AppBar commonAppbar(BuildContext context, String title) {
  return new AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _commonAppBarIcon(Icons.home, context),
        Text(title),
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
        Navigator.of(context).pushReplacementNamed('/');
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