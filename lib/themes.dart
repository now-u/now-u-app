import 'package:flutter/material.dart';
import 'package:nowu/assets/constants.dart';

// TODO This apply doesn't seem to work
final baseTextTheme =
    const TextTheme().apply(displayColor: Colors.black, fontFamily: 'Nunito');

final textTheme = baseTextTheme.merge(
  const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Nunito',
      color: Colors.black,
      fontSize: 36,
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 30,
      fontWeight: FontWeight.w800,
      // TODO Do we need these?
      // letterSpacing: 24, // Bold
      // height: 34,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Nunito',
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Nunito',
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Nunito',
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Nunito',
      // TODO Check this color is applied (over the baseTextTheme color)
      color: Color.fromRGBO(119, 119, 119, 1),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    ),
    labelLarge: TextStyle(
      // TODO Check this font family is applied (over the baseTextTheme fontFamily)
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w500, // SemiBold
    ),
    labelMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(115, 159, 177, 1),
    ),
    labelSmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
);

final primaryTextButtonStyle = TextButton.styleFrom(
  backgroundColor: Colors.transparent,
  foregroundColor: CustomColors.brandColor,
  textStyle: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700),
  padding: const EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 16.0,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

final primaryFilledButtonStyle = TextButton.styleFrom(
  backgroundColor: CustomColors.brandColor,
  foregroundColor: Colors.white,
  textStyle: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700),
  padding: const EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 36.0,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);

final secondaryFilledButtonStyle = TextButton.styleFrom(
  elevation: 10,
  shadowColor: tileBoxShadowLight.color,
  backgroundColor: Colors.white,
  foregroundColor: CustomColors.brandColor,
).merge(primaryTextButtonStyle);

final regularTheme = ThemeData(
  primaryColor: CustomColors.brandColor,
  fontFamily: fontFamily,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: CustomColors.brandColor,
    // TODO This is does not quite work as white isn't very visible on orange
    onPrimary: Colors.white,
    secondary: const Color.fromRGBO(255, 220, 121, 1),
    onSecondary: Colors.black,
    // TODO What is this really?
    surface: Colors.white,
    onSurface: Colors.black,
    error: const Color.fromRGBO(211, 0, 1, 1),
    // TODO Really?
    onError: Colors.white,
  ),
  textTheme: textTheme,
  buttonTheme: ButtonThemeData(
    buttonColor: CustomColors.brandColor,
    disabledColor: CustomColors.brandColor.withOpacity(0.5),
    height: 48,
  ),
  textButtonTheme: TextButtonThemeData(style: primaryTextButtonStyle),
  filledButtonTheme: FilledButtonThemeData(style: primaryFilledButtonStyle),
  // TODO Bring back!
  // TODO Fix buttons
  searchBarTheme: SearchBarThemeData(
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    hintStyle: WidgetStatePropertyAll(
      textTheme.bodyLarge!.copyWith(color: Colors.grey),
    ),
    elevation: const WidgetStatePropertyAll(tileElevation),
    shadowColor: WidgetStatePropertyAll(tileBoxShadowLight.color),
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.transparent,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromRGBO(221, 221, 221, 0.2),
    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
    border: const OutlineInputBorder(),
    focusedBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      borderSide: BorderSide(color: CustomColors.brandColor, width: 2.0),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      borderSide:
          BorderSide(color: Color.fromRGBO(222, 224, 232, 1), width: 2.0),
    ),
    hintStyle: textTheme.labelMedium,
  ),
);

final darkTheme = regularTheme.copyWith(
  textTheme:
      textTheme.apply(displayColor: Colors.white, bodyColor: Colors.white),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: CustomColors.brandColor,
    // TODO This is does not quite work as white isn't very visible on orange
    onPrimary: Colors.white,
    secondary: const Color.fromRGBO(255, 220, 121, 1),
    onSecondary: Colors.black,
    // TODO What is this really?
    surface: Colors.white,
    onSurface: Colors.black,
    error: const Color.fromRGBO(211, 0, 1, 1),
    // TODO Really?
    onError: Colors.white,
  ),
);
