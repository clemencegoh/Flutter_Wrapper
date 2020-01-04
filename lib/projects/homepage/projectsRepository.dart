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
        "QR Scanner",
        "Scan QR codes or generate one",
        Icons.crop_free,
        "/qrCodeScanner"
      ),
      Project(
        "Location Prediction",
        "Submit current location "
            "or guess where you'll be having lunch today!",
        Icons.not_listed_location,
        "/lunchPredictor"
      ),
      Project(
          "Simple Webview",
          "Basic webview in flutter",
          Icons.open_in_browser,
          "/webview"
      ),
    ];
  }

}