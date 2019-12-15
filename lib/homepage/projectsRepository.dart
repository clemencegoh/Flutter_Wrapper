import 'package:flutter_app/homepage/projectsModel.dart';
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
        Icons.navigate_next,
        "/projects.lunchPredictor"
      ),

    ];
  }

}