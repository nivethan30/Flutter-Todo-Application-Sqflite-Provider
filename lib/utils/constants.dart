import 'package:flutter/material.dart';

class Constants {
  static const String appTitle = "Todo App";
  static const String appBarTitle = "Todo App";

  static const TextStyle poppinsNormalLight =
      TextStyle(fontFamily: 'Poppins', color: Colors.black);

  static const TextStyle poppinsNormalDark =
      TextStyle(fontFamily: 'Poppins', color: Colors.white);
}

/// A helper function to create a [TextStyle] with the Poppins font and light color (black).
/// The [fontSize] parameter is required and sets the font size of the style.
///
/// Returns a [TextStyle] with the Poppins font, black color, and the given [fontSize].
TextStyle poppinsLight(double fontSize) {
  return TextStyle(
      fontFamily: 'Poppins', color: Colors.black, fontSize: fontSize);
}

/// A helper function to create a [TextStyle] with the Poppins font and dark color (white).
/// The [fontSize] parameter is required and sets the font size of the style.
///
/// Returns a [TextStyle] with the Poppins font, white color, and the given [fontSize].
TextStyle poppinsDark(double fontSize) {
  return TextStyle(
      fontFamily: 'Poppins', color: Colors.white, fontSize: fontSize);
}

class Assets {
  static const String taskImage = "assets/images/tasks.png";
}
