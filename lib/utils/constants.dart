import 'package:flutter/material.dart';

class Constants {
  static const String appTitle = "Todo App";
  static const String appBarTitle = "Todo App";

  static const TextStyle poppinsNormalLight =
      TextStyle(fontFamily: 'Poppins', color: Colors.black);

  static const TextStyle poppinsNormalDark =
      TextStyle(fontFamily: 'Poppins', color: Colors.white);
}

TextStyle poppinsLight(double fontSize) {
  return TextStyle(
      fontFamily: 'Poppins', color: Colors.black, fontSize: fontSize);
}

TextStyle poppinsDark(double fontSize) {
  return TextStyle(
      fontFamily: 'Poppins', color: Colors.white, fontSize: fontSize);
}
