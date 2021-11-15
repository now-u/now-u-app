import 'dart:io' show Platform;
import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter/foundation.dart' show kReleaseMode;

/// Whether we are currently running tests
bool testMode = Platform.environment.containsKey('FLUTTER_TEST');
/// Whether the app is currently running in debug mode 
bool devMode = !testMode && !kReleaseMode;

/// Primary brand color
Color brandColor = Color.fromRGBO(255, 136, 0, 1);

//-- Accent colours --//
/// Venetian Red
Color accentRed = Color.fromRGBO(211, 0, 1, 1);
/// Sunflower
Color accentYellow = Color.fromRGBO(243, 183, 0, 1);
/// Salomie
Color accentLightYellow = Color.fromRGBO(243, 183, 0, 1);
/// Oxford Blue
Color accentBlue = Color.fromRGBO(1, 26, 67, 1);

//-- Neutrals --//
Color white = Colors.white;
Color greyLight1 = Color.fromRGBO(247, 248, 252, 1);
Color greyLight2 = Color.fromRGBO(222, 224, 232, 1);
Color greyMed1 = Color.fromRGBO(189, 192, 205, 1);
Color greyDark1 = Color.fromRGBO(155, 159, 177, 1);
Color greyDark2 = Color.fromRGBO(109, 113, 129, 1);
Color black1 = Color.fromRGBO(55, 58, 74, 1);
Color black2 = Color.fromRGBO(23, 23, 26, 1);

//-- Fonts --//
String fontFamily = "Nunito";
String fontFamilySecondary = "Poppins";

class CustomFontSize {
  int heading1 = 36;
  int heading2 = 30;
  int heading3 = 24;
  int heading4 = 18;
  int heading5 = 16;
  int body = 16;
}


