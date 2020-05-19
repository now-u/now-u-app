import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app/pages/Tabs.dart';
import 'package:app/pages/other/SplashScreen.dart';
import 'package:app/pages/intro/IntroPage.dart';
import 'package:app/pages/login/login.dart';

import 'package:app/assets/dynamicLinks.dart';

import 'package:app/locator.dart';

import 'package:app/models/User.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/redux/reducers.dart';
import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: darkBlue
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

// This is a really annoying color thing --> Makes our fav color into material colour
Map<int, Color> darkBlueMap ={50:Color.fromRGBO(36,35,52, .1),100:Color.fromRGBO(36,35,52, .2),200:Color.fromRGBO(36,35,52, .3),300:Color.fromRGBO(36,35,52, .4),400:Color.fromRGBO(36,35,52, .5),500:Color.fromRGBO(36,35,52, .6),600:Color.fromRGBO(36,35,52, .7),700:Color.fromRGBO(36,35,52, .8),800:Color.fromRGBO(36,35,52, .9),900:Color.fromRGBO(36,35,52, 1),};
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

// Accent Colours

//List<Widget> _pages = <Widget>[Campaigns(campaigns), Home(), Profile(_user)];

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int deepLinkPageIndex = 1;
  Widget page;
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
        middleware: [appStateMiddleware],
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));

    return StoreProvider<AppState>(
      store: store, 
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => StoreBuilder<AppState>(
            onInit: (store) { 
              store.dispatch(GetCampaignsAction());
              store.dispatch(GetUserDataAction());
              //store.dispatch(InitaliseState);
            },
            builder: (BuildContext context, Store<AppState> store) =>
              //store.state.campaigns == null 
              //|| store.state.campaigns.getActiveCampaigns() == null
              //|| store.state.campaigns.activeLength() < 3
              //store.state.loading
              //store.state.user.getId() == -1
              //?
              ////SplashScreen()
              //LoginPage()
              //:
              MyHomePage(deepLinkPageIndex),
          ),
          'intro': (context) => IntroPage(),
          'login': (context) => LoginPage(),
          'home': (context) => MyHomePage(3),
          //'/campaign': (context) => TabsPage(currentPage: TabPage.Campaigns),
          //'/home': (context) => TabsPage(currentPage: TabPage.Home),
          //TODO add login point
          //'logoin': 
          //TODO splash screen should be a route
          //'splashscreen': (context) =>
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
          fontFamily: 'Nunito',
          primaryTextTheme: TextTheme(
                headline1: TextStyle(
                  color: black,
                  fontSize: 36,
                  fontWeight: FontWeight.w600 // Bold
                ),
                headline2: TextStyle(
                  color: black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600 // Bold
                ),
                headline3: TextStyle(
                  color: black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500 // SemiBold
                ),
                headline4: TextStyle(
                  color: black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400 // Regular
                ),
                // Capitalize
                headline5: TextStyle(
                  color: black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400 // Regular
                ),

                bodyText1: TextStyle(
                  color: black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400, // Regular
                  fontStyle: FontStyle.normal,
                ),
                // Italic
                bodyText2: TextStyle(
                  color: lightGrey,
                  fontSize: 14,
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
        //home: 
        //  StoreBuilder<AppState>(
        //    onInit: (store) { 
        //      store.dispatch(GetCampaignsAction());
        //      store.dispatch(GetUserDataAction());
        //      //store.dispatch(InitaliseState);
        //    },
        //    builder: (BuildContext context, Store<AppState> store) =>
        //      //store.state.campaigns == null 
        //      //|| store.state.campaigns.getActiveCampaigns() == null
        //      //|| store.state.campaigns.activeLength() < 3
        //      store.state.loading
        //      ?
        //      SplashScreen()
        //      //Container(
        //      //  color: Colors.red,
        //      //  height: MediaQuery.of(context).size.height,
        //      //  width: MediaQuery.of(context).size.width,
        //      //)
        //      :
        //      MyHomePage(store, deepLinkPageIndex),
        //  )  
       )
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int currentIndex;

  MyHomePage(this.currentIndex);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  DevToolsStore<AppState> store;
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  } 

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      print("App resumed");
      //Function onClick = (int index) {
      //  print("Setting current index");
      //  setState(() {
      //    currentIndex = index;
      //  });
      //};
      //handleDynamicLinks(
      //  onClick 
      //);
    }
  }

  @override 
  Widget build(BuildContext context) {
  print("The currentIndex is");
  print(currentIndex);
    return
      StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) {
            print("Before splash screen user is");
            print(viewModel.user.getName());
            print(currentIndex);
            return TabsPage(currentPage: TabPage.Home);
          },
      );
  }
}
