import 'package:flutter/material.dart';

class QRService  {
  Widget getWidget(int choice){
    switch (choice){
      case 0: return _appBody();
      case 1: return _anotherAppBody();
      case 2: return Container();
      default: return _appBody();
    }
  }

  Widget _appBody(){
    return Container(
      child: Text("Hello World"),
    );
  }

  Widget _anotherAppBody(){
    return Container(
      child: Text("PAGE 2!"),
    );
  }
}