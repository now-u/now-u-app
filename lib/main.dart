import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:app/pages/other/SplashScreen.dart';

//import 'package:app/assets/dynamicLinks.dart';

import 'package:app/routes.dart';
import 'package:app/locator.dart';
import 'package:app/services/dynamicLinks.dart';

import 'package:app/models/State.dart';

import 'package:app/redux/reducers.dart';
import 'package:app/redux/middleware.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: darkBlue),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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

const MaterialColor whiteMaterial = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

Color white = Colors.white;
Color orange = Color.fromRGBO(255, 136, 0, 1);
Color blue = Color.fromRGBO(1, 26, 67, 1);
Color black = Colors.black;
Color lightGrey = Color.fromRGBO(119, 119, 119, 1);

// Analytics

FirebaseAnalytics analytics = FirebaseAnalytics();

// Accent Colours

//List<Widget> _pages = <Widget>[Campaigns(campaigns), Home(), Profile(_user)];

class Keys {
  static final navKey = new GlobalKey<NavigatorState>();
}

Future<Map> getSecrets() async {
  String data = await rootBundle.loadString('assets/json/secrets.json');
  Map jsondata = json.decode(data);
  return jsondata;
  //return jsondata.containsKey(value) ? jsondata[value] : null;
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int deepLinkPageIndex = 1;
  Widget page;
  Uri _deepLink;
  @override
  void initState() {
    // TODO: implement initState
    setupLocator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
      middleware: [appStateMiddleware, thunkMiddleware],
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));

    return StoreProvider<AppState>(
        store: store,
        child:
            //FutureBuilder(
            //  future: getSecrets(),
            //  builder:(BuildContext context, AsyncSnapshot snapshot) {
            //    if (!snapshot.hasData) {
            //      return Container();
            //    }
            //return Wiredash(
            //  projectId: snapshot.data['wiredash_project_id'],
            //  secret: snapshot.data['wiredash_key'],
            //  navigatorKey: Keys.navKey,
            //  child:
            MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: Keys.navKey,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          initialRoute: '/',
          //initialRoute: Routes.intro,
          onGenerateRoute: initRoutes,
          routes: {
            '/': (BuildContext context) => StoreBuilder<AppState>(
                  onInitialBuild: (store) {
                    DynamicLinkService deepLinkService =
                        locator<DynamicLinkService>();
                    deepLinkService.getLink().then((Uri u) {
                      store.dispatch(initStore(u));
                    });
                  },
                  builder: (BuildContext context, Store<AppState> store) =>
                      SplashScreen(),
                ),
          },
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            applyElevationOverlayColor: true,
            fontFamily: 'Nunito',
            primaryTextTheme: TextTheme(
              headline1: TextStyle(
                  color: black,
                  fontSize: 36,
                  fontWeight: FontWeight.w800 // Black
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
                  fontWeight: FontWeight.w600 // SemiBold
                  ),
              headline4: TextStyle(
                  color: black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500 // Regular
                  ),
              // Capitalize
              headline5: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400 // Regular
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
        ));
    //}
    //),
    //);
  }
}
