import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleWidth;
  static late double scaleHeight;

  static const double figmaWidth = 360; // Figma ka design width
  static const double figmaHeight = 800; // Figma ka design height

  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;

    scaleWidth = screenWidth / figmaWidth;
    scaleHeight = screenHeight / figmaHeight;
  }

  // Width adjust karne ka function
  static double w(double width) => width * scaleWidth;

  // Height adjust karne ka function
  static double h(double height) => height * scaleHeight;

  // Font size adjust karne ka function
  static double sp(double fontSize) => fontSize * scaleWidth;
}
