import 'package:flutter_app/projects/homepage/projectsModel.dart';
import 'package:flutter/material.dart';

// Singleton
class ProjectsData {
  ProjectsData._constructor();

  static final ProjectsData _data = ProjectsData._constructor();

  factory ProjectsData(){
    return _data;
  }

  List<Project> getAllData(){
    return [
      Project(
        "Location Prediction",
        "Submit current location "
            "or guess where you'll be having lunch today!",
        Icons.not_listed_location,
        "/lunchPredictor"
      ),
      Project(
          "Simple Webview",
          "Attempt at trying to show the capabilities of webview on flutter",
          Icons.open_in_browser,
          "/webview"
      ),
    ];
  }

}