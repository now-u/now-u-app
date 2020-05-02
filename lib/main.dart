import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app/pages/Tabs.dart';

import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
import 'package:app/assets/SplashScreen.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/dynamicLinks.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
        middleware: [appStateMiddleware],
    );

    return StoreProvider<AppState>(
      store: store, 
      child: MaterialApp(
        title: 'Flutter Demo',
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
          fontFamily: 'Raleway',
          primaryTextTheme: TextTheme(
                // Page Header
                title: TextStyle(
                      fontSize: 46, 
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),  
                subtitle: TextStyle(
                      fontSize: 30, 
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),  
                
                headline : TextStyle(
                      fontSize: 31,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                body1: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                body2: TextStyle(
                      fontSize: 22, 
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                button : TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                    ),
                display1: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'PeaceSans',
                    ),
                display2: TextStyle(
                      fontSize: 26,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                display3: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                
              ),
          primarySwatch: darkBlue,
          buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.fromSwatch(
                  backgroundColor: Color.fromRGBO(36, 35, 52, 1),
                  ),
                buttonColor: Color.fromRGBO(36, 35, 52, 1), 
                textTheme: ButtonTextTheme.primary
              ),
          primaryColorDark: Color.fromRGBO(36, 35, 52, 1),
          buttonColor: Color.fromRGBO(36, 35, 52, 1),
          textSelectionColor: Colors.white, // Text used on top of 

        ),
        home: 
          StoreBuilder<AppState>(
            onInit: (store) { 
              //store.dispatch(GetCampaingsAction());
              store.dispatch(GetUserDataAction());
            },
            builder: (BuildContext context, Store<AppState> store) =>
              //store.state.campaigns == null 
              //|| store.state.campaigns.getActiveCampaigns() == null
              //|| store.state.campaigns.activeLength() < 3
              store.state.loading
              ?
              Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )
              :
              MyHomePage(store, deepLinkPageIndex),
          )  
       )
    );
  }
}

class MyHomePage extends StatefulWidget {
  final DevToolsStore<AppState> store;
  final int currentIndex;

  MyHomePage(this.store, this.currentIndex);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  DevToolsStore<AppState> store;
  int currentIndex;

  @override
  void initState() {
    store = widget.store;
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
            return TabsPage(viewModel, currentIndex: currentIndex);
          },
      );
  }
}
