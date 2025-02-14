import 'package:flutter/material.dart';
//screen size for making app resposive
class ScreenSize {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
}
