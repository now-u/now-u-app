import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

// --- Env --- //

/// Whether we are currently running tests
bool testMode = Platform.environment.containsKey('FLUTTER_TEST');

/// Whether the app is currently running in debug mode
bool devMode = !testMode && !kReleaseMode;

const PRIVACY_POLICY_URL =
    'https://now-u-docs.s3.eu-west-2.amazonaws.com/now-u+privacy+policy.pdf';
const TERMS_AND_CONDITIONS_URL =
    'https://now-u-docs.s3.eu-west-2.amazonaws.com/now-u+user+terms+and+conditions.pdf';

const LOCAL_CAUSES_API_URL = '192.168.1.65:3001';
const LOCAL_STACK_URL = 'http://192.168.1.11';

// devMode ? "staging.api.now-u.com" : "api.now-u.com";

// const CAUSES_API_URL = '$LOCAL_STACK_URL:8000';
const CAUSES_API_URL = 'https://causes.dev.apiv2.now-u.com/';

// const SEARCH_SERVICE_URL = '$LOCAL_STACK_URL:7700';
const SEARCH_SERVICE_URL = 'https://search.dev.apiv2.now-u.com/';
const SEARCH_SERVICE_KEY = 'bff96ec33b85544b836bc50a8708e9d61833ff2f38d0f83f44f7a700e3bb89cc';

class CustomColors {
  /// Primary brand color
  static Color brandColor = const Color.fromRGBO(255, 136, 0, 1);

  // --- Styles --- //

  //-- Accent colours --//
  /// Venetian Red
  static Color accentRed = const Color.fromRGBO(211, 0, 1, 1);

  /// Sunflower
  static Color accentYellow = const Color.fromRGBO(243, 183, 0, 1);

  /// Salomie
  static Color accentLightYellow = const Color.fromRGBO(243, 183, 0, 1);

  /// Oxford Blue
  static Color accentBlue = const Color.fromRGBO(1, 26, 67, 1);

  //-- Neutrals --//
  static Color white = Colors.white;
  static Color greyLight1 = const Color.fromRGBO(247, 248, 252, 1);
  static Color greyLight2 = const Color.fromRGBO(222, 224, 232, 1);
  static Color greyMed1 = const Color.fromRGBO(189, 192, 205, 1);
  static Color greyDark1 = const Color.fromRGBO(155, 159, 177, 1);
  static Color greyDark2 = const Color.fromRGBO(109, 113, 129, 1);
  static Color black1 = const Color.fromRGBO(55, 58, 74, 1);
  static Color black2 = const Color.fromRGBO(23, 23, 26, 1);

  //-- Background --//
  static Color lightOrange = const Color.fromRGBO(255, 243, 230, 0.5);

  //-- Shadow colors --//
}

//-- Fonts --//
String fontFamily = 'Nunito';
String fontFamilySecondary = 'Poppins';

class CustomFontSize {
  static double heading1 = 36;
  static double heading2 = 30;
  static double heading3 = 24;
  static double heading4 = 18;
  static double heading5 = 16;
  static double body = 16;
}

class CustomPaddingSize {
  static double xsmall = 8;
  static double small = 14;
  static double normal = 20;
  static double large = 40;
}

TextStyle exploreHeading = TextStyle(
  color: CustomColors.black1,
  fontSize: CustomFontSize.heading2,
  fontWeight: FontWeight.w400, // Regular
  fontStyle: FontStyle.normal,
);

const Offset tileShadowOffset = Offset(0, 3);
const double tileShadowBlurRadius = 20;
final BorderRadius tileBorderRadius = BorderRadius.circular(8);
const BoxShadow tileBoxShadowLight = BoxShadow(
  color: Color.fromRGBO(0, 45, 96, 0.08),
  offset: tileShadowOffset,
  blurRadius: tileShadowBlurRadius,
);
const BoxShadow tileBoxShadowDark = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.08),
  offset: tileShadowOffset,
  blurRadius: tileShadowBlurRadius,
);

const double tileElevation = 10;

//-- Themes --//

final ligthThemeBaseTextStyle = TextStyle(
  color: CustomColors.black1,
);

// Used through majority of app
final lightTheme = ThemeData(
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    bodyMedium: ligthThemeBaseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: ligthThemeBaseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
);

// Used during on boarding
final darkTheme = ThemeData();
