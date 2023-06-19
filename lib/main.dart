import 'dart:io';

import 'package:nowu/locator.dart';
import 'package:nowu/managers/dialog_manager.dart';
import 'package:nowu/pages/other/startup_view.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Fix for network request on old devices: "CERTIFICATE_VERIFY_FAILED"
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  await Firebase.initializeApp();
  runApp(App());
}

// This is a really annoying color thing --> Makes our fav color into material colour
Map<int, Color> darkBlueMap = {
  50: Color.fromRGBO(36, 35, 52, .1),
  100: Color.fromRGBO(36, 35, 52, .2),
  200: Color.fromRGBO(36, 35, 52, .3),
  300: Color.fromRGBO(36, 35, 52, .4),
  400: Color.fromRGBO(36, 35, 52, .5),
  500: Color.fromRGBO(36, 35, 52, .6),
  600: Color.fromRGBO(36, 35, 52, .7),
  700: Color.fromRGBO(36, 35, 52, .8),
  800: Color.fromRGBO(36, 35, 52, .9),
  900: Color.fromRGBO(36, 35, 52, 1),
};
MaterialColor darkBlue = MaterialColor(0xFF242334, darkBlueMap);

const MaterialColor whiteMaterial = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

Color white = Colors.white;
Color orange = Color.fromRGBO(255, 136, 0, 1);
Color blue = Color.fromRGBO(1, 26, 67, 1);
Color black = Color.fromRGBO(55, 58, 74, 1);
Color lightGrey = Color.fromRGBO(119, 119, 119, 1);

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int deepLinkPageIndex = 1;
  Widget? page;
  @override
  void initState() {
    // Initalise Fireabse app
    setupLocator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: locator<NavigationService>().navigatorKey,
      navigatorObservers: [
        locator<AnalyticsService>().getAnalyticsObserver(),
      ],
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: widget!)),
      ),
      home: StartUpView(),
      onGenerateRoute: initRoutes as Route<dynamic>? Function(RouteSettings)?,
      theme: ThemeData(
        // This is the theme of the application.
        applyElevationOverlayColor: true,
        fontFamily: 'Nunito',
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
              color: black, fontSize: 36, fontWeight: FontWeight.w800 // Black
              ),
          headline2: TextStyle(
            color: black,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            //letterSpacing: 24, // Bold
            //height: 34,
          ),
          headline3: TextStyle(
              color: black,
              fontSize: 24,
              fontWeight: FontWeight.w700 // SemiBold
              ),
          headline4: TextStyle(
              color: black, fontSize: 18, fontWeight: FontWeight.w500 // Regular
              ),
          // Capitalize
          headline5: TextStyle(
              color: black, fontSize: 16, fontWeight: FontWeight.w400 // Regular
              ),

          bodyText1: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w400, // Regular
            fontStyle: FontStyle.normal,
            //height: 24,
          ),
          // Italic
          bodyText2: TextStyle(
            color: lightGrey,
            fontSize: 16,
            fontWeight: FontWeight.w400, // Regular
            fontStyle: FontStyle.italic,
          ),

          // Used on Dark Blue background
          headline6: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.w400, // Regular
          ),
          button: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500, // SemiBold
            fontStyle: FontStyle.normal,
          ),
        ),

        // Brand Colour
        primaryColor: orange,
        // Accent Colours
        // Sunflower
        accentColor: Color.fromRGBO(243, 183, 0, 1),
        // Venetian Red --> Accent
        errorColor: Color.fromRGBO(211, 0, 1, 1),
        // Salomie
        primaryColorLight: Color.fromRGBO(255, 220, 121, 1),
        // Oxford Blue
        primaryColorDark: blue,
        buttonColor: orange,
        //textSelectionColor: white, // Text used on top of
      ),
    );
  }
}
