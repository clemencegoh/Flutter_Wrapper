// Helper functions for calculating BMI
import 'dart:math';

String calculateBMI(double height, double weight){
  return (weight/pow(height, 2)).toStringAsFixed(2);
}

// Note that the below are estimates based off US Navy measurement equations developed in 1984
String calculateBodyFatPercentageMale(int age, double weight, double height, double neck, double waist){
  var BFP = 495/(1.0324 - 0.19077 * log((waist - neck)) + 0.15456 * log(height)) - 450;
  return BFP.toStringAsFixed(2);
}

String calculateBodyFatPercentageFemale(int age, double weight, double height, double neck, double waist, double hip){
  var BFP = 495/(1.29579 - 0.35004 * log((waist + hip - neck)) + 0.22100 * log(height)) - 450;
  return BFP.toStringAsFixed(2);
}

