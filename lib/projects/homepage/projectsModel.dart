import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  Project(this.title, this.description, this.icon, this.route);
}

class QuoteItem {
  String quote;
  String author;

  QuoteItem({this.quote, this.author});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'quote': quote,
      'author': author,
    };
    return map;
  }

  QuoteItem.fromMap(Map<String, dynamic> map) {
    quote = map['quote'];
    author = map['author'];
  }
}